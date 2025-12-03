mod farm_fingerprint;
mod from_base64;
mod from_hex;
mod md5;
mod net_functions;
mod sha1;
mod sha256;
mod sha512;
mod to_base64;
mod to_hex;

use yachtsql_core::error::{Error, Result};
use yachtsql_core::types::Value;
use yachtsql_optimizer::expr::Expr;

use super::super::ProjectionWithExprExec;
use crate::RecordBatch;

impl ProjectionWithExprExec {
    pub(super) fn evaluate_crypto_hash_network_function(
        name: &str,
        args: &[Expr],
        batch: &RecordBatch,
        row_idx: usize,
    ) -> Result<Value> {
        match name {
            "MD5" => Self::eval_md5(args, batch, row_idx),
            "SHA1" => Self::eval_sha1(args, batch, row_idx),
            "SHA256" => Self::eval_sha256(args, batch, row_idx),
            "SHA512" => Self::eval_sha512(args, batch, row_idx),
            "FARM_FINGERPRINT" => Self::eval_farm_fingerprint(args, batch, row_idx),
            "TO_HEX" => Self::eval_to_hex(args, batch, row_idx),
            "FROM_HEX" => Self::eval_from_hex(args, batch, row_idx),
            "TO_BASE64" => Self::eval_to_base64(args, batch, row_idx),
            "FROM_BASE64" => Self::eval_from_base64(args, batch, row_idx),
            name if name.starts_with("NET.") => Self::eval_net_function(name, args, batch, row_idx),
            _ => Err(Error::unsupported_feature(format!(
                "Unknown crypto/hash/network function: {}",
                name
            ))),
        }
    }
}
