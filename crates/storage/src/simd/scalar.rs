#![allow(dead_code)]

pub fn sum_i64(data: &[i64]) -> i64 {
    data.iter().sum()
}

pub fn sum_f64(data: &[f64]) -> f64 {
    data.iter().sum()
}

pub fn sum_i64_masked(data: &[i64], nulls: &[u8]) -> i64 {
    assert_eq!(data.len(), nulls.len());
    data.iter()
        .zip(nulls.iter())
        .map(|(&d, &n)| d * (n as i64))
        .sum()
}

pub fn sum_f64_masked(data: &[f64], nulls: &[u8]) -> f64 {
    assert_eq!(data.len(), nulls.len());
    data.iter()
        .zip(nulls.iter())
        .map(|(&d, &n)| d * (n as f64))
        .sum()
}

pub fn count_nonzero_i64(data: &[i64]) -> usize {
    data.iter().filter(|&&x| x != 0).count()
}

pub fn filter_gt_i64(data: &[i64], threshold: i64) -> Vec<usize> {
    let mut indices = Vec::with_capacity(data.len());
    for (i, &value) in data.iter().enumerate() {
        if value > threshold {
            indices.push(i);
        }
    }
    indices
}

pub fn filter_gt_i64_with_nulls(data: &[i64], nulls: &[u8], threshold: i64) -> Vec<usize> {
    assert_eq!(data.len(), nulls.len());
    let mut indices = Vec::with_capacity(data.len());
    for (i, (&value, &null_flag)) in data.iter().zip(nulls.iter()).enumerate() {
        if value > threshold && null_flag != 0 {
            indices.push(i);
        }
    }
    indices
}

pub fn filter_gt_f64(data: &[f64], threshold: f64) -> Vec<usize> {
    let mut indices = Vec::with_capacity(data.len());
    for (i, &value) in data.iter().enumerate() {
        if value > threshold {
            indices.push(i);
        }
    }
    indices
}

pub fn min_i64(data: &[i64]) -> Option<i64> {
    data.iter().min().copied()
}

pub fn max_i64(data: &[i64]) -> Option<i64> {
    data.iter().max().copied()
}

pub fn filter_eq_i64(data: &[i64], value: i64) -> Vec<usize> {
    let mut indices = Vec::with_capacity(data.len());
    for (i, &v) in data.iter().enumerate() {
        if v == value {
            indices.push(i);
        }
    }
    indices
}

pub fn filter_lt_i64(data: &[i64], threshold: i64) -> Vec<usize> {
    let mut indices = Vec::with_capacity(data.len());
    for (i, &value) in data.iter().enumerate() {
        if value < threshold {
            indices.push(i);
        }
    }
    indices
}

pub fn filter_gte_i64(data: &[i64], threshold: i64) -> Vec<usize> {
    let mut indices = Vec::with_capacity(data.len());
    for (i, &value) in data.iter().enumerate() {
        if value >= threshold {
            indices.push(i);
        }
    }
    indices
}

pub fn filter_lte_i64(data: &[i64], threshold: i64) -> Vec<usize> {
    let mut indices = Vec::with_capacity(data.len());
    for (i, &value) in data.iter().enumerate() {
        if value <= threshold {
            indices.push(i);
        }
    }
    indices
}

pub fn filter_ne_i64(data: &[i64], value: i64) -> Vec<usize> {
    let mut indices = Vec::with_capacity(data.len());
    for (i, &v) in data.iter().enumerate() {
        if v != value {
            indices.push(i);
        }
    }
    indices
}

pub fn avg_i64(data: &[i64]) -> Option<f64> {
    if data.is_empty() {
        return None;
    }
    let sum: i64 = data.iter().sum();
    Some(sum as f64 / data.len() as f64)
}

pub fn avg_f64(data: &[f64]) -> Option<f64> {
    if data.is_empty() {
        return None;
    }
    let sum: f64 = data.iter().sum();
    Some(sum / data.len() as f64)
}

pub fn avg_i64_masked(data: &[i64], nulls: &[u8]) -> Option<f64> {
    assert_eq!(data.len(), nulls.len());
    let sum = sum_i64_masked(data, nulls);
    let count = nulls.iter().filter(|&&n| n != 0).count();
    if count == 0 {
        None
    } else {
        Some(sum as f64 / count as f64)
    }
}

pub fn avg_f64_masked(data: &[f64], nulls: &[u8]) -> Option<f64> {
    assert_eq!(data.len(), nulls.len());
    let sum = sum_f64_masked(data, nulls);
    let count = nulls.iter().filter(|&&n| n != 0).count();
    if count == 0 {
        None
    } else {
        Some(sum / count as f64)
    }
}
