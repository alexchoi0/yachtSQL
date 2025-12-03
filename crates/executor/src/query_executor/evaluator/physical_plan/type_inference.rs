use std::rc::Rc;

use yachtsql_core::types::Value;
use yachtsql_functions::json::JsonValueEvalOptions;
use yachtsql_storage::Schema;

use super::{
    FeatureRegistryContextGuard, ProjectionWithExprExec, SubqueryExecutor,
    SubqueryExecutorContextGuard,
};

#[allow(dead_code)]
impl ProjectionWithExprExec {
    pub(crate) fn enter_feature_registry_context(
        registry: Rc<yachtsql_capability::FeatureRegistry>,
    ) -> FeatureRegistryContextGuard {
        FeatureRegistryContextGuard::set(registry)
    }

    pub(crate) fn enter_subquery_executor_context(
        executor: Rc<dyn SubqueryExecutor>,
    ) -> SubqueryExecutorContextGuard {
        SubqueryExecutorContextGuard::set(executor)
    }

    fn infer_case_type(
        when_then: &[(crate::optimizer::expr::Expr, crate::optimizer::expr::Expr)],
        else_expr: Option<&crate::optimizer::expr::Expr>,
        schema: &Schema,
    ) -> crate::types::DataType {
        use yachtsql_core::types::DataType;

        for (when_cond, then_expr) in when_then {
            let _ = Self::infer_expr_type_with_schema(when_cond, schema);
            let _ = Self::infer_expr_type_with_schema(then_expr, schema);
        }

        if let Some(else_e) = else_expr
            && let Some(data_type) = Self::infer_expr_type_with_schema(else_e, schema)
        {
            return data_type;
        }

        if let Some((_, then_expr)) = when_then.first()
            && let Some(data_type) = Self::infer_expr_type_with_schema(then_expr, schema)
        {
            return data_type;
        }

        DataType::String
    }

    fn is_empty_array_literal(expr: &crate::optimizer::expr::Expr) -> bool {
        matches!(expr,
            crate::optimizer::expr::Expr::Literal(
                crate::optimizer::expr::LiteralValue::Array(elements)
            ) if elements.is_empty()
        )
    }

    fn infer_array_type_from_first_arg(
        args: &[crate::optimizer::expr::Expr],
        schema: &Schema,
    ) -> Option<crate::types::DataType> {
        use yachtsql_core::types::DataType;

        args.first().and_then(|first_arg| {
            Self::infer_expr_type_with_schema(first_arg, schema).and_then(|data_type| {
                match data_type {
                    DataType::Array(element_type) => Some(DataType::Array(element_type)),
                    _ => None,
                }
            })
        })
    }

    fn infer_array_type_with_element_fallback(
        array_arg_idx: usize,
        element_arg_idx: usize,
        args: &[crate::optimizer::expr::Expr],
        schema: &Schema,
    ) -> Option<crate::types::DataType> {
        use yachtsql_core::types::DataType;

        if args.len() <= array_arg_idx.max(element_arg_idx) {
            return None;
        }

        if Self::is_empty_array_literal(&args[array_arg_idx])
            && let Some(element_type) =
                Self::infer_expr_type_with_schema(&args[element_arg_idx], schema)
        {
            return Some(DataType::Array(Box::new(element_type)));
        }

        Self::infer_expr_type_with_schema(&args[array_arg_idx], schema).and_then(|data_type| {
            match data_type {
                DataType::Array(element_type) => Some(DataType::Array(element_type)),
                _ => None,
            }
        })
    }

    fn infer_array_type_from_non_empty_array(
        args: &[crate::optimizer::expr::Expr],
        schema: &Schema,
    ) -> Option<crate::types::DataType> {
        use yachtsql_core::types::DataType;

        for arg in args {
            if !Self::is_empty_array_literal(arg)
                && let Some(DataType::Array(element_type)) =
                    Self::infer_expr_type_with_schema(arg, schema)
            {
                return Some(DataType::Array(element_type));
            }
        }

        Self::infer_array_type_from_first_arg(args, schema)
    }

    fn cast_type_to_data_type(
        cast_type: &crate::optimizer::expr::CastDataType,
    ) -> crate::types::DataType {
        use yachtsql_core::types::DataType;
        use yachtsql_optimizer::expr::CastDataType;

        match cast_type {
            CastDataType::Int64 => DataType::Int64,
            CastDataType::Float64 => DataType::Float64,
            CastDataType::Numeric(precision_scale) => DataType::Numeric(*precision_scale),
            CastDataType::String => DataType::String,
            CastDataType::Bytes => DataType::Bytes,
            CastDataType::Bool => DataType::Bool,
            CastDataType::Date => DataType::Date,
            CastDataType::DateTime => DataType::DateTime,
            CastDataType::Time => DataType::Time,
            CastDataType::Timestamp => DataType::Timestamp,
            CastDataType::TimestampTz => DataType::TimestampTz,
            CastDataType::Geography => DataType::Geography,
            CastDataType::Json => DataType::Json,
            CastDataType::Array(inner) => {
                DataType::Array(Box::new(Self::cast_type_to_data_type(inner.as_ref())))
            }
            CastDataType::Vector(dims) => DataType::Vector(*dims),
            CastDataType::Interval => DataType::Interval,
            CastDataType::Uuid => DataType::Uuid,
            CastDataType::Hstore => DataType::Hstore,
            CastDataType::MacAddr => DataType::MacAddr,
            CastDataType::MacAddr8 => DataType::MacAddr8,
            CastDataType::Custom(name) => DataType::Custom(name.clone()),
        }
    }

    fn infer_binary_op_type(
        op: &crate::optimizer::expr::BinaryOp,
        left_type: Option<crate::types::DataType>,
        right_type: Option<crate::types::DataType>,
    ) -> Option<crate::types::DataType> {
        use yachtsql_core::types::DataType;
        use yachtsql_optimizer::expr::BinaryOp;

        match op {
            BinaryOp::Equal
            | BinaryOp::NotEqual
            | BinaryOp::LessThan
            | BinaryOp::LessThanOrEqual
            | BinaryOp::GreaterThan
            | BinaryOp::GreaterThanOrEqual
            | BinaryOp::And
            | BinaryOp::Or => Some(DataType::Bool),

            BinaryOp::Add => match (&left_type, &right_type) {
                (Some(DataType::Timestamp), Some(DataType::Interval))
                | (Some(DataType::Interval), Some(DataType::Timestamp))
                | (Some(DataType::TimestampTz), Some(DataType::Interval))
                | (Some(DataType::Interval), Some(DataType::TimestampTz)) => {
                    Some(DataType::Timestamp)
                }

                (Some(DataType::Date), Some(DataType::Interval))
                | (Some(DataType::Interval), Some(DataType::Date)) => Some(DataType::Date),

                (Some(DataType::Numeric(_)), _) | (_, Some(DataType::Numeric(_))) => {
                    Some(DataType::Numeric(None))
                }
                (Some(DataType::Float64), _) | (_, Some(DataType::Float64)) => {
                    Some(DataType::Float64)
                }
                (Some(DataType::Int64), Some(DataType::Int64)) => Some(DataType::Int64),
                _ => None,
            },
            BinaryOp::Subtract => match (&left_type, &right_type) {
                (Some(DataType::Timestamp), Some(DataType::Interval))
                | (Some(DataType::TimestampTz), Some(DataType::Interval)) => {
                    Some(DataType::Timestamp)
                }

                (Some(DataType::Timestamp), Some(DataType::Timestamp))
                | (Some(DataType::TimestampTz), Some(DataType::TimestampTz))
                | (Some(DataType::Timestamp), Some(DataType::TimestampTz))
                | (Some(DataType::TimestampTz), Some(DataType::Timestamp)) => {
                    Some(DataType::Interval)
                }

                (Some(DataType::Date), Some(DataType::Interval)) => Some(DataType::Date),

                (Some(DataType::Numeric(_)), _) | (_, Some(DataType::Numeric(_))) => {
                    Some(DataType::Numeric(None))
                }
                (Some(DataType::Float64), _) | (_, Some(DataType::Float64)) => {
                    Some(DataType::Float64)
                }
                (Some(DataType::Int64), Some(DataType::Int64)) => Some(DataType::Int64),
                _ => None,
            },
            BinaryOp::Multiply | BinaryOp::Divide | BinaryOp::Modulo => {
                match (left_type, right_type) {
                    (Some(DataType::Numeric(_)), _) | (_, Some(DataType::Numeric(_))) => {
                        Some(DataType::Numeric(None))
                    }
                    (Some(DataType::Float64), _) | (_, Some(DataType::Float64)) => {
                        Some(DataType::Float64)
                    }
                    (Some(DataType::Int64), Some(DataType::Int64)) => Some(DataType::Int64),
                    _ => None,
                }
            }

            BinaryOp::VectorL2Distance
            | BinaryOp::VectorInnerProduct
            | BinaryOp::VectorCosineDistance => Some(DataType::Float64),

            BinaryOp::ArrayContains | BinaryOp::ArrayContainedBy | BinaryOp::ArrayOverlap => {
                Some(DataType::Bool)
            }

            _ => None,
        }
    }

    fn infer_unary_op_type(
        op: &crate::optimizer::expr::UnaryOp,
        operand_type: Option<crate::types::DataType>,
    ) -> Option<crate::types::DataType> {
        use yachtsql_core::types::DataType;
        use yachtsql_optimizer::expr::UnaryOp;

        match op {
            UnaryOp::IsNull | UnaryOp::IsNotNull | UnaryOp::Not => Some(DataType::Bool),
            UnaryOp::Negate | UnaryOp::Plus => operand_type,
        }
    }

    fn infer_literal_type(
        lit: &crate::optimizer::expr::LiteralValue,
    ) -> Option<crate::types::DataType> {
        use yachtsql_core::types::DataType;
        use yachtsql_optimizer::expr::LiteralValue;

        match lit {
            LiteralValue::Null => None,
            LiteralValue::Boolean(_) => Some(DataType::Bool),
            LiteralValue::Int64(_) => Some(DataType::Int64),
            LiteralValue::Float64(_) => Some(DataType::Float64),
            LiteralValue::Numeric(_) => Some(DataType::Numeric(None)),
            LiteralValue::String(_) => Some(DataType::String),
            LiteralValue::Bytes(_) => Some(DataType::Bytes),
            LiteralValue::Date(_) => Some(DataType::Date),
            LiteralValue::Timestamp(_) => Some(DataType::Timestamp),
            LiteralValue::Json(_) => Some(DataType::Json),
            LiteralValue::Array(elements) => {
                let element_type = elements
                    .first()
                    .and_then(Self::infer_expr_type)
                    .unwrap_or(DataType::String);
                Some(DataType::Array(Box::new(element_type)))
            }
            LiteralValue::Uuid(_) => Some(DataType::Uuid),
            LiteralValue::Vector(vec) => Some(DataType::Vector(vec.len())),
            LiteralValue::Interval(_) => Some(DataType::Interval),
            LiteralValue::Range(_) => {
                Some(DataType::Range(yachtsql_core::types::RangeType::Int4Range))
            }
            LiteralValue::Point(_) => Some(DataType::Point),
            LiteralValue::PgBox(_) => Some(DataType::PgBox),
            LiteralValue::Circle(_) => Some(DataType::Circle),
            LiteralValue::MacAddr(_) => Some(DataType::MacAddr),
            LiteralValue::MacAddr8(_) => Some(DataType::MacAddr8),
        }
    }

    fn infer_coalesce_type(
        args: &[crate::optimizer::expr::Expr],
        schema: &Schema,
    ) -> Option<crate::types::DataType> {
        for arg in args {
            if let Some(arg_type) = Self::infer_expr_type_with_schema(arg, schema) {
                return Some(arg_type);
            }
        }
        None
    }

    fn infer_first_arg_type(
        args: &[crate::optimizer::expr::Expr],
        schema: &Schema,
    ) -> Option<crate::types::DataType> {
        args.first()
            .and_then(|arg| Self::infer_expr_type_with_schema(arg, schema))
    }

    #[inline]
    fn infer_comparison_operator_type() -> Option<crate::types::DataType> {
        use yachtsql_core::types::DataType;
        Some(DataType::Bool)
    }

    fn infer_function_type(
        name: &str,
        args: &[crate::optimizer::expr::Expr],
        schema: &Schema,
    ) -> Option<crate::types::DataType> {
        use yachtsql_core::types::DataType;

        let func_name = name.to_uppercase();
        match func_name.as_str() {
            "YACHTSQL.IS_FEATURE_ENABLED" => Some(DataType::Bool),

            "ABS" | "CEIL" | "CEILING" | "FLOOR" | "ROUND" | "TRUNC" | "TRUNCATE" | "SQRT"
            | "EXP" | "LN" | "LOG" | "LOG10" | "SIN" | "COS" | "TAN" | "ASIN" | "ACOS" | "ATAN"
            | "ATAN2" | "DEGREES" | "RADIANS" | "PI" | "POWER" | "POW" | "MOD" | "RANDOM"
            | "RAND" | "TO_NUMBER" => Some(DataType::Float64),

            "SIGN" => Some(DataType::Int64),

            "SAFE_ADD" | "SAFE_SUBTRACT" | "SAFE_MULTIPLY" | "SAFE_DIVIDE" => {
                if args.len() >= 2 {
                    let left_type = Self::infer_expr_type_with_schema(&args[0], schema);
                    let right_type = Self::infer_expr_type_with_schema(&args[1], schema);

                    match (left_type, right_type) {
                        (Some(DataType::Float64), _) | (_, Some(DataType::Float64)) => {
                            Some(DataType::Float64)
                        }
                        (Some(DataType::Numeric(_)), _) | (_, Some(DataType::Numeric(_))) => {
                            Some(DataType::Numeric(None))
                        }

                        (Some(DataType::Int64), Some(DataType::Int64)) => Some(DataType::Int64),

                        _ => Some(DataType::Int64),
                    }
                } else {
                    Some(DataType::Int64)
                }
            }

            "SAFE_NEGATE" => {
                if !args.is_empty() {
                    let arg_type = Self::infer_expr_type_with_schema(&args[0], schema);
                    match arg_type {
                        Some(DataType::Float64) => Some(DataType::Float64),
                        Some(DataType::Numeric(_)) => Some(DataType::Numeric(None)),
                        _ => Some(DataType::Int64),
                    }
                } else {
                    Some(DataType::Int64)
                }
            }

            "CONCAT" | "TRIM" | "LTRIM" | "RTRIM" | "REPLACE" | "UPPER" | "LOWER" | "SUBSTR"
            | "SUBSTRING" | "LEFT" | "RIGHT" | "REVERSE" | "REPEAT" | "LPAD" | "RPAD" | "CHR"
            | "INITCAP" | "TO_CHAR" | "TRANSLATE" | "FORMAT" | "QUOTE_IDENT" | "QUOTE_LITERAL"
            | "REGEXP_EXTRACT" | "REGEXP_REPLACE" => Some(DataType::String),

            "LENGTH" | "CHAR_LENGTH" | "CHARACTER_LENGTH" | "POSITION" | "STRPOS" | "ASCII" => {
                Some(DataType::Int64)
            }

            "STARTS_WITH" | "ENDS_WITH" | "REGEXP_CONTAINS" => Some(DataType::Bool),

            "MD5" | "SHA1" | "SHA256" | "SHA512" => Some(DataType::String),

            "FARM_FINGERPRINT" => Some(DataType::Int64),

            "TO_HEX" => Some(DataType::String),
            "FROM_HEX" => Some(DataType::Bytes),

            "CURRENT_DATE" => Some(DataType::Date),
            "CURRENT_TIMESTAMP" | "NOW" => Some(DataType::Timestamp),
            "DATE" | "DATE_ADD" | "DATE_SUB" | "DATE_TRUNC" => Some(DataType::Date),
            "TIMESTAMP_DIFF" => Some(DataType::Int64),
            "TIMESTAMP_TRUNC" => Some(DataType::Timestamp),

            "PARSE_DATE" | "STR_TO_DATE" => Some(DataType::Date),
            "PARSE_TIMESTAMP" => Some(DataType::Timestamp),

            "MAKE_DATE" => Some(DataType::Date),
            "MAKE_TIMESTAMP" | "CURRENT_TIME" => Some(DataType::Timestamp),

            "EXTRACT" | "DATE_PART" | "YEAR" | "MONTH" | "DAY" | "HOUR" | "MINUTE" | "SECOND"
            | "QUARTER" | "WEEK" | "DOW" | "DOY" | "DAYOFWEEK" | "DAYOFYEAR" | "DATE_DIFF"
            | "DATEDIFF" | "AGE" => Some(DataType::Int64),

            "FORMAT_DATE" | "FORMAT_TIMESTAMP" => Some(DataType::String),

            "NEXTVAL" | "CURRVAL" | "SETVAL" | "LASTVAL" => Some(DataType::Int64),

            "ARRAY_LENGTH" | "ARRAY_POSITION" => Some(DataType::Int64),
            "ARRAY_CONTAINS" => Some(DataType::Bool),
            "SPLIT" => Some(DataType::Array(Box::new(DataType::String))),

            "GENERATE_ARRAY" => Some(DataType::Array(Box::new(DataType::Int64))),
            "GENERATE_DATE_ARRAY" => Some(DataType::Array(Box::new(DataType::Date))),
            "GENERATE_TIMESTAMP_ARRAY" => Some(DataType::Array(Box::new(DataType::Timestamp))),
            "GENERATE_UUID" => Some(DataType::String),
            "GENERATE_UUID_ARRAY" => Some(DataType::Array(Box::new(DataType::String))),

            "ARRAY_REVERSE" | "ARRAY_SORT" | "ARRAY_DISTINCT" | "ARRAY_REPLACE" => {
                Self::infer_array_type_from_first_arg(args, schema)
            }

            "ARRAY_APPEND" | "ARRAY_REMOVE" => {
                Self::infer_array_type_with_element_fallback(0, 1, args, schema)
            }

            "ARRAY_PREPEND" => Self::infer_array_type_with_element_fallback(1, 0, args, schema),

            "ARRAY_CONCAT" | "ARRAY_CAT" => {
                Self::infer_array_type_from_non_empty_array(args, schema)
            }

            "GREATEST" | "LEAST" => {
                let mut has_float = false;
                let mut has_int = false;
                let mut has_string = false;
                let mut result_type: Option<DataType> = None;

                for arg in args {
                    if let Some(arg_type) = Self::infer_expr_type_with_schema(arg, schema) {
                        match arg_type {
                            DataType::Float64 => has_float = true,
                            DataType::Int64 => has_int = true,
                            DataType::String => has_string = true,
                            _ => {}
                        }
                        if result_type.is_none() {
                            result_type = Some(arg_type);
                        }
                    }
                }

                if has_float && has_int {
                    Some(DataType::Float64)
                } else if has_string {
                    Some(DataType::String)
                } else {
                    result_type
                }
            }

            "COALESCE" => Self::infer_coalesce_type(args, schema),
            "IFNULL" | "NULLIF" => Self::infer_first_arg_type(args, schema),

            "IF" => args
                .get(1)
                .and_then(|arg| Self::infer_expr_type_with_schema(arg, schema)),

            "COUNT" => Some(DataType::Int64),
            "SUM" | "AVG" | "MIN" | "MAX" | "MODE" => None,
            "STDDEV" | "STDDEV_POP" | "STDDEV_SAMP" | "VARIANCE" | "VAR_POP" | "VAR_SAMP"
            | "MEDIAN" | "PERCENTILE_CONT" | "PERCENTILE_DISC" | "CORR" | "COVAR_POP"
            | "COVAR_SAMP" => Some(DataType::Float64),

            "JSON_AGG" | "JSON_OBJECT_AGG" => Some(DataType::Json),

            "JSON_EXTRACT" | "JSON_EXTRACT_JSON" | "JSON_ARRAY" | "JSON_OBJECT" | "PARSE_JSON"
            | "TO_JSON" => Some(DataType::Json),

            "TO_JSON_STRING" => Some(DataType::String),

            "JSON_QUERY" => Some(DataType::Json),
            "JSON_TYPE" => Some(DataType::String),
            "JSON_EXISTS" => Some(DataType::Bool),
            "JSONB_PATH_EXISTS" | "JSONB_PATH_MATCH" => Some(DataType::Bool),
            "JSONB_PATH_QUERY_FIRST" => Some(DataType::Json),
            "JSONB_CONTAINS" => Some(DataType::Bool),
            "JSONB_CONCAT" | "JSONB_DELETE" | "JSONB_DELETE_PATH" | "JSONB_SET" => {
                Some(DataType::Json)
            }
            "JSON_LENGTH" => Some(DataType::Int64),
            "JSON_KEYS" => Some(DataType::Json),

            "IS_JSON_VALUE" | "IS_JSON_ARRAY" | "IS_JSON_OBJECT" | "IS_JSON_SCALAR" => {
                Some(DataType::Bool)
            }
            "IS_NOT_JSON_VALUE" | "IS_NOT_JSON_ARRAY" | "IS_NOT_JSON_OBJECT"
            | "IS_NOT_JSON_SCALAR" => Some(DataType::Bool),

            "JSON_VALUE" => args
                .get(2)
                .and_then(|arg| {
                    if let crate::optimizer::expr::Expr::Literal(
                        crate::optimizer::expr::LiteralValue::String(s),
                    ) = arg
                    {
                        JsonValueEvalOptions::from_literal(&Value::string(s.clone()))
                            .map(|options| options.inferred_return_type())
                            .ok()
                    } else {
                        None
                    }
                })
                .or(Some(DataType::String)),
            "JSON_VALUE_TEXT" => Some(DataType::String),
            "JSON_EXTRACT_PATH_ARRAY" => Some(DataType::Json),
            "JSON_EXTRACT_PATH_ARRAY_TEXT" => Some(DataType::String),

            "BIT_AND" | "BIT_OR" | "BIT_XOR" => Some(DataType::Int64),

            "BOOL_AND" | "BOOL_OR" | "EVERY" => Some(DataType::Bool),

            "APPROX_COUNT_DISTINCT" => Some(DataType::Int64),
            "APPROX_QUANTILES" => Some(DataType::Array(Box::new(DataType::Float64))),
            "APPROX_TOP_COUNT" | "APPROX_TOP_SUM" => {
                Some(DataType::Array(Box::new(DataType::String)))
            }

            "INTERVAL_LITERAL" => None,

            "NET.IP_FROM_STRING"
            | "NET.SAFE_IP_FROM_STRING"
            | "NET.IPV4_FROM_INT64"
            | "NET.IP_NET_MASK"
            | "NET.IP_TRUNC" => Some(DataType::Bytes),
            "NET.IPV4_TO_INT64" => Some(DataType::Int64),
            "NET.IP_TO_STRING" | "NET.HOST" | "NET.PUBLIC_SUFFIX" | "NET.REG_DOMAIN" => {
                Some(DataType::String)
            }

            "KEYS.KEYSET_CHAIN" | "AEAD.ENCRYPT" | "DETERMINISTIC_ENCRYPT" => Some(DataType::Bytes),
            "AEAD.DECRYPT_BYTES" | "DETERMINISTIC_DECRYPT_BYTES" => Some(DataType::Bytes),
            "AEAD.DECRYPT_STRING" | "DETERMINISTIC_DECRYPT_STRING" => Some(DataType::String),

            "TO_TSVECTOR"
            | "TO_TSQUERY"
            | "PLAINTO_TSQUERY"
            | "PHRASETO_TSQUERY"
            | "WEBSEARCH_TO_TSQUERY"
            | "TS_HEADLINE"
            | "STRIP"
            | "SETWEIGHT"
            | "TSVECTOR_CONCAT"
            | "TSQUERY_AND"
            | "TSQUERY_OR"
            | "TSQUERY_NOT" => Some(DataType::String),
            "TS_RANK" | "TS_RANK_CD" => Some(DataType::Float64),
            "TS_MATCH" => Some(DataType::Bool),
            "TSVECTOR_LENGTH" => Some(DataType::Int64),

            _ => None,
        }
    }

    pub fn infer_expr_type_with_schema(
        expr: &crate::optimizer::expr::Expr,
        schema: &Schema,
    ) -> Option<crate::types::DataType> {
        use yachtsql_core::types::{DataType, StructField};
        use yachtsql_optimizer::expr::Expr;

        match expr {
            Expr::Column { name, .. } => schema.field(name).map(|f| f.data_type.clone()),
            Expr::Literal(lit) => Self::infer_literal_type(lit),
            Expr::BinaryOp { left, op, right } => {
                let left_type = Self::infer_expr_type_with_schema(left, schema);
                let right_type = Self::infer_expr_type_with_schema(right, schema);
                Self::infer_binary_op_type(op, left_type, right_type)
            }
            Expr::UnaryOp { op, expr } => {
                let operand_type = Self::infer_expr_type_with_schema(expr, schema);
                Self::infer_unary_op_type(op, operand_type)
            }
            Expr::Function { name, args } => Self::infer_function_type(name.as_str(), args, schema),
            Expr::Cast { data_type, .. } => Some(Self::cast_type_to_data_type(data_type)),
            Expr::TryCast { data_type, .. } => Some(Self::cast_type_to_data_type(data_type)),

            Expr::Between { .. }
            | Expr::InList { .. }
            | Expr::TupleInList { .. }
            | Expr::TupleInSubquery { .. } => Self::infer_comparison_operator_type(),
            Expr::StructLiteral { fields } => {
                let mut struct_fields = Vec::with_capacity(fields.len());
                for field in fields {
                    let field_type = field
                        .declared_type
                        .clone()
                        .or_else(|| Self::infer_expr_type_with_schema(&field.expr, schema))?;
                    struct_fields.push(StructField {
                        name: field.name.clone(),
                        data_type: field_type,
                    });
                }
                Some(DataType::Struct(struct_fields))
            }
            Expr::StructFieldAccess { expr, field } => {
                match Self::infer_expr_type_with_schema(expr, schema)? {
                    DataType::Struct(fields) => fields
                        .into_iter()
                        .find(|f| f.name == *field)
                        .map(|f| f.data_type),
                    _ => None,
                }
            }
            Expr::ScalarSubquery { subquery } => {
                crate::query_executor::execution::infer_scalar_subquery_type_static(
                    subquery,
                    Some(schema),
                )
            }
            Expr::ArrayIndex { array, .. } => {
                match Self::infer_expr_type_with_schema(array, schema)? {
                    DataType::Array(elem_type) => Some(*elem_type),
                    _ => None,
                }
            }
            Expr::ArraySlice { array, .. } => Self::infer_expr_type_with_schema(array, schema),
            Expr::Aggregate { name, args, .. } => {
                Self::infer_function_type(name.as_str(), args, schema)
            }
            Expr::Case {
                when_then,
                else_expr,
                ..
            } => {
                if let Some(else_e) = else_expr {
                    if let Some(t) = Self::infer_expr_type_with_schema(else_e, schema) {
                        return Some(t);
                    }
                }
                for (_, then_expr) in when_then {
                    if let Some(t) = Self::infer_expr_type_with_schema(then_expr, schema) {
                        return Some(t);
                    }
                }
                None
            }
            _ => None,
        }
    }

    pub(super) fn infer_expr_type(
        expr: &crate::optimizer::expr::Expr,
    ) -> Option<crate::types::DataType> {
        use yachtsql_core::types::{DataType, StructField};
        use yachtsql_optimizer::expr::Expr;

        match expr {
            Expr::Literal(lit) => Self::infer_literal_type(lit),
            Expr::BinaryOp { left, op, right } => {
                let left_type = Self::infer_expr_type(left);
                let right_type = Self::infer_expr_type(right);
                Self::infer_binary_op_type(op, left_type, right_type)
            }
            Expr::UnaryOp { op, expr } => {
                let operand_type = Self::infer_expr_type(expr);
                Self::infer_unary_op_type(op, operand_type)
            }
            Expr::Function { name, args } => {
                let empty_schema = Schema::new();
                Self::infer_function_type(name.as_str(), args, &empty_schema)
            }
            Expr::Cast { data_type, .. } => Some(Self::cast_type_to_data_type(data_type)),
            Expr::TryCast { data_type, .. } => Some(Self::cast_type_to_data_type(data_type)),

            Expr::Between { .. }
            | Expr::InList { .. }
            | Expr::TupleInList { .. }
            | Expr::TupleInSubquery { .. } => Self::infer_comparison_operator_type(),
            Expr::StructLiteral { fields } => {
                let mut struct_fields = Vec::with_capacity(fields.len());
                for field in fields {
                    let field_type = field
                        .declared_type
                        .clone()
                        .or_else(|| Self::infer_expr_type(&field.expr))?;
                    struct_fields.push(StructField {
                        name: field.name.clone(),
                        data_type: field_type,
                    });
                }
                Some(DataType::Struct(struct_fields))
            }
            Expr::StructFieldAccess { expr, field } => match Self::infer_expr_type(expr)? {
                DataType::Struct(fields) => fields
                    .into_iter()
                    .find(|f| f.name == *field)
                    .map(|f| f.data_type),
                _ => None,
            },
            Expr::ArrayIndex { array, .. } => match Self::infer_expr_type(array)? {
                DataType::Array(elem_type) => Some(*elem_type),
                _ => None,
            },
            Expr::ArraySlice { array, .. } => Self::infer_expr_type(array),
            Expr::Aggregate { name, args, .. } => {
                let empty_schema = Schema::new();
                Self::infer_function_type(name.as_str(), args, &empty_schema)
            }
            Expr::Case {
                when_then,
                else_expr,
                ..
            } => {
                if let Some(else_e) = else_expr {
                    if let Some(t) = Self::infer_expr_type(else_e) {
                        return Some(t);
                    }
                }
                for (_, then_expr) in when_then {
                    if let Some(t) = Self::infer_expr_type(then_expr) {
                        return Some(t);
                    }
                }
                None
            }
            _ => None,
        }
    }
}
