use yachtsql_executor::explain::{MetricValue, ProfilerDisabled, ProfilerEnabled};

#[test]
fn test_profiler_basic() {
    let profiler = ProfilerEnabled::new();

    {
        let mut timer = profiler.start_operator(0);
        std::thread::sleep(std::time::Duration::from_millis(5));
        timer.record_batch(1000);
    }

    {
        let mut timer = profiler.start_operator(1);
        timer.record_custom("selectivity".to_string(), MetricValue::Percentage(25.5));
        std::thread::sleep(std::time::Duration::from_millis(3));
        timer.record_batch(255);
    }

    {
        let mut timer = profiler.start_operator(2);
        std::thread::sleep(std::time::Duration::from_millis(2));
        timer.record_batch(255);
    }

    let metrics = profiler.get_all_metrics();
    assert_eq!(metrics.len(), 3);

    let scan_metrics = metrics.get(&0).unwrap();
    assert_eq!(scan_metrics.rows_produced, 1000);
    assert!(scan_metrics.execution_time.as_millis() >= 5);

    let filter_metrics = metrics.get(&1).unwrap();
    assert_eq!(filter_metrics.rows_produced, 255);
    assert!(filter_metrics.custom_metrics.contains_key("selectivity"));

    let proj_metrics = metrics.get(&2).unwrap();
    assert_eq!(proj_metrics.rows_produced, 255);
}

#[test]
fn test_profiler_disabled() {
    let profiler = ProfilerDisabled::new();

    {
        let mut timer = profiler.start_operator(0);
        timer.record_batch(1000);
    }

    let metrics = profiler.get_all_metrics();
    assert_eq!(metrics.len(), 0);
}

#[test]
fn test_profiler_custom_metrics() {
    let profiler = ProfilerEnabled::new();

    {
        let mut timer = profiler.start_operator(0);
        timer.record_custom("hash_table_size".to_string(), MetricValue::Count(10000));
        timer.record_custom("memory_usage".to_string(), MetricValue::Bytes(2048 * 1024));
        timer.record_batch(500);
    }

    let metrics = profiler.get_metrics(0).unwrap();
    assert_eq!(metrics.custom_metrics.len(), 2);
    assert!(metrics.custom_metrics.contains_key("hash_table_size"));
    assert!(metrics.custom_metrics.contains_key("memory_usage"));
}

#[test]
fn test_explain_with_profiler_integration() {
    use yachtsql_executor::explain::{ExplainOptions, format_plan};
    use yachtsql_optimizer::plan::PlanNode;

    let plan = PlanNode::Scan {
        table_name: "users".to_string(),
        alias: None,
        projection: Some(vec!["id".to_string(), "name".to_string()]),
    };

    let profiler = ProfilerEnabled::new();
    {
        let mut timer = profiler.start_operator(0);
        timer.record_batch(1000);
    }

    let options = ExplainOptions {
        analyze: true,
        verbose: true,
        profiler_metrics: Some(profiler.get_all_metrics()),
    };

    let result = format_plan(&plan, options).unwrap();

    assert!(result.num_rows() > 0);

    if let Ok(rows) = result.rows() {
        let output: String = rows
            .iter()
            .flat_map(|r| r.values())
            .map(|v| v.to_string())
            .collect::<Vec<_>>()
            .join("\n");

        assert!(output.contains("TableScan"));
        assert!(output.contains("rows=1000"));
        assert!(output.contains("time="));
    }
}

#[test]
fn test_explain_format_with_metrics() {
    use yachtsql_executor::explain::{ExplainOptions, format_plan};
    use yachtsql_optimizer::expr::Expr;
    use yachtsql_optimizer::plan::PlanNode;

    let scan = PlanNode::Scan {
        table_name: "users".to_string(),
        alias: None,
        projection: None,
    };

    let plan = PlanNode::Filter {
        input: Box::new(scan),
        predicate: Expr::BinaryOp {
            left: Box::new(Expr::Column {
                name: "age".to_string(),
                table: None,
            }),
            op: yachtsql_optimizer::expr::BinaryOp::GreaterThan,
            right: Box::new(Expr::Literal(
                yachtsql_optimizer::expr::LiteralValue::Int64(25),
            )),
        },
    };

    let profiler = ProfilerEnabled::new();

    {
        let mut timer = profiler.start_operator(1);
        timer.record_batch(1000);
    }

    {
        let mut timer = profiler.start_operator(0);
        timer.record_custom("selectivity".to_string(), MetricValue::Percentage(50.0));
        timer.record_batch(500);
    }

    let options = ExplainOptions {
        analyze: true,
        verbose: false,
        profiler_metrics: Some(profiler.get_all_metrics()),
    };

    let result = format_plan(&plan, options).unwrap();

    if let Ok(rows) = result.rows() {
        let output: String = rows
            .iter()
            .flat_map(|r| r.values())
            .map(|v| v.to_string())
            .collect::<Vec<_>>()
            .join("\n");

        assert!(output.contains("Filter"));
        assert!(output.contains("selectivity="));

        assert!(output.contains("TableScan"));
    }
}
