#[cfg(target_arch = "aarch64")]
mod neon;

#[cfg(target_arch = "x86_64")]
mod avx;

mod scalar;

pub mod backend;

#[cfg(target_arch = "x86_64")]
pub use avx::*;
#[cfg(target_arch = "x86_64")]
pub use backend::Avx2Backend;
#[cfg(target_arch = "aarch64")]
pub use backend::NeonBackend;
pub use backend::{DefaultBackend, ScalarBackend, SimdBackend, backend_info};
#[cfg(target_arch = "aarch64")]
pub use neon::*;
#[cfg(not(any(target_arch = "aarch64", target_arch = "x86_64")))]
pub use scalar::*;

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_sum_i64() {
        let data = vec![1i64, 2, 3, 4, 5, 6, 7, 8, 9, 10];
        assert_eq!(sum_i64(&data), 55);
    }

    #[test]
    fn test_sum_i64_empty() {
        let data: Vec<i64> = vec![];
        assert_eq!(sum_i64(&data), 0);
    }

    #[test]
    fn test_sum_f64() {
        let data = vec![1.5, 2.5, 3.5, 4.5];
        assert_eq!(sum_f64(&data), 12.0);
    }

    #[test]
    fn test_count_nonzero_i64() {
        let data = vec![1i64, 0, 3, 0, 5, 6, 0, 8];
        assert_eq!(count_nonzero_i64(&data), 5);
    }

    #[test]
    fn test_filter_gt_i64() {
        let data = vec![1i64, 5, 3, 8, 2, 9, 4, 7];
        let indices = filter_gt_i64(&data, 5);
        assert_eq!(indices, vec![3, 5, 7]);
    }

    #[test]
    fn test_filter_gt_f64() {
        let data = vec![1.5, 5.5, 3.5, 8.5];
        let indices = filter_gt_f64(&data, 5.0);
        assert_eq!(indices, vec![1, 3]);
    }

    #[test]
    fn test_sum_f64_masked_no_nulls() {
        let data = vec![1.0, 2.0, 3.0, 4.0, 5.0];
        let nulls = vec![1u8, 1, 1, 1, 1];
        let sum = sum_f64_masked(&data, &nulls);
        assert_eq!(sum, 15.0);
    }

    #[test]
    fn test_sum_f64_masked_all_nulls() {
        let data = vec![1.0, 2.0, 3.0, 4.0, 5.0];
        let nulls = vec![0u8, 0, 0, 0, 0];
        let sum = sum_f64_masked(&data, &nulls);
        assert_eq!(sum, 0.0);
    }

    #[test]
    fn test_sum_f64_masked_mixed_nulls() {
        let data = vec![1.0, 2.0, 3.0, 4.0, 5.0];
        let nulls = vec![1u8, 0, 1, 0, 1];
        let sum = sum_f64_masked(&data, &nulls);
        assert_eq!(sum, 9.0);
    }

    #[test]
    fn test_sum_f64_masked_alternating_nulls() {
        let data = vec![10.0, 20.0, 30.0, 40.0, 50.0, 60.0, 70.0, 80.0];
        let nulls = vec![1u8, 0, 1, 0, 1, 0, 1, 0];
        let sum = sum_f64_masked(&data, &nulls);
        assert_eq!(sum, 160.0);
    }

    #[test]
    fn test_sum_f64_masked_large_array() {
        let data: Vec<f64> = (0..100).map(|i| i as f64).collect();
        let nulls = vec![1u8; 100];
        let sum = sum_f64_masked(&data, &nulls);
        let expected: f64 = (0..100).map(|i| i as f64).sum();
        assert_eq!(sum, expected);
    }

    #[test]
    fn test_sum_f64_masked_large_with_nulls() {
        let data: Vec<f64> = (0..100).map(|i| i as f64).collect();
        let nulls: Vec<u8> = (0..100).map(|i| if i % 3 == 0 { 0 } else { 1 }).collect();
        let sum = sum_f64_masked(&data, &nulls);
        let expected: f64 = (0..100).filter(|&i| i % 3 != 0).map(|i| i as f64).sum();
        assert_eq!(sum, expected);
    }

    #[test]
    fn test_sum_f64_masked_negative_values() {
        let data = vec![-5.0, -3.0, -1.0, 1.0, 3.0, 5.0];
        let nulls = vec![1u8, 0, 1, 1, 0, 1];
        let sum = sum_f64_masked(&data, &nulls);
        assert_eq!(sum, 0.0);
    }

    #[test]
    fn test_sum_f64_masked_fractional_values() {
        let data = vec![0.1, 0.2, 0.3, 0.4, 0.5];
        let nulls = vec![1u8, 1, 0, 1, 1];
        let sum = sum_f64_masked(&data, &nulls);
        assert!((sum - 1.2).abs() < 1e-10);
    }

    #[test]
    fn test_sum_f64_masked_empty() {
        let data: Vec<f64> = vec![];
        let nulls: Vec<u8> = vec![];
        let sum = sum_f64_masked(&data, &nulls);
        assert_eq!(sum, 0.0);
    }

    #[test]
    fn test_sum_i64_masked_no_nulls() {
        let data = vec![1i64, 2, 3, 4, 5];
        let nulls = vec![1u8, 1, 1, 1, 1];
        let sum = sum_i64_masked(&data, &nulls);
        assert_eq!(sum, 15);
    }

    #[test]
    fn test_sum_i64_masked_all_nulls() {
        let data = vec![1i64, 2, 3, 4, 5];
        let nulls = vec![0u8, 0, 0, 0, 0];
        let sum = sum_i64_masked(&data, &nulls);
        assert_eq!(sum, 0);
    }

    #[test]
    fn test_sum_i64_masked_mixed_nulls() {
        let data = vec![1i64, 2, 3, 4, 5];
        let nulls = vec![1u8, 0, 1, 0, 1];
        let sum = sum_i64_masked(&data, &nulls);
        assert_eq!(sum, 9);
    }

    #[test]
    fn test_sum_i64_masked_alternating_nulls() {
        let data = vec![10i64, 20, 30, 40, 50, 60, 70, 80];
        let nulls = vec![1u8, 0, 1, 0, 1, 0, 1, 0];
        let sum = sum_i64_masked(&data, &nulls);
        assert_eq!(sum, 160);
    }

    #[test]
    fn test_sum_i64_masked_large_array() {
        let data: Vec<i64> = (0..100).collect();
        let nulls = vec![1u8; 100];
        let sum = sum_i64_masked(&data, &nulls);
        let expected: i64 = (0..100).sum();
        assert_eq!(sum, expected);
    }

    #[test]
    fn test_sum_i64_masked_large_with_nulls() {
        let data: Vec<i64> = (0..100).collect();
        let nulls: Vec<u8> = (0..100).map(|i| if i % 3 == 0 { 0 } else { 1 }).collect();
        let sum = sum_i64_masked(&data, &nulls);
        let expected: i64 = (0i64..100).filter(|&i| i % 3 != 0).sum();
        assert_eq!(sum, expected);
    }

    #[test]
    fn test_sum_i64_masked_negative_values() {
        let data = vec![-5i64, -3, -1, 1, 3, 5];
        let nulls = vec![1u8, 0, 1, 1, 0, 1];
        let sum = sum_i64_masked(&data, &nulls);
        assert_eq!(sum, 0);
    }

    #[test]
    fn test_sum_i64_masked_empty() {
        let data: Vec<i64> = vec![];
        let nulls: Vec<u8> = vec![];
        let sum = sum_i64_masked(&data, &nulls);
        assert_eq!(sum, 0);
    }

    #[test]
    fn test_sum_i64_masked_single_element() {
        let data = vec![42i64];
        let nulls = vec![1u8];
        assert_eq!(sum_i64_masked(&data, &nulls), 42);

        let nulls = vec![0u8];
        assert_eq!(sum_i64_masked(&data, &nulls), 0);
    }

    #[test]
    fn test_sum_i64_masked_odd_length() {
        let data = vec![1i64, 2, 3, 4, 5, 6, 7];
        let nulls = vec![1u8, 1, 1, 1, 1, 1, 1];
        assert_eq!(sum_i64_masked(&data, &nulls), 28);
    }
}
