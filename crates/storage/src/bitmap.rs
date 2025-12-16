use aligned_vec::AVec;

#[derive(Debug, Clone)]
pub struct NullBitmap {
    data: AVec<u8>,
}

impl NullBitmap {
    pub fn new_valid(len: usize) -> Self {
        let mut data = AVec::with_capacity(64, len);
        data.resize(len, 1u8);
        Self { data }
    }

    pub fn new_null(len: usize) -> Self {
        let mut data = AVec::with_capacity(64, len);
        data.resize(len, 0u8);
        Self { data }
    }

    pub fn from_vec(data: Vec<u8>) -> Self {
        let mut aligned = AVec::with_capacity(64, data.len());
        aligned.extend_from_slice(&data);
        Self { data: aligned }
    }

    #[inline]
    pub fn len(&self) -> usize {
        self.data.len()
    }

    #[inline]
    pub fn is_empty(&self) -> bool {
        self.data.is_empty()
    }

    #[inline]
    pub fn is_null(&self, index: usize) -> bool {
        self.data[index] == 0
    }

    #[inline]
    pub fn is_valid(&self, index: usize) -> bool {
        self.data[index] != 0
    }

    #[inline]
    pub fn set_valid(&mut self, index: usize) {
        self.data[index] = 1;
    }

    #[inline]
    pub fn set_null(&mut self, index: usize) {
        self.data[index] = 0;
    }

    #[inline]
    pub fn set(&mut self, index: usize, is_valid: bool) {
        if is_valid {
            self.set_valid(index);
        } else {
            self.set_null(index);
        }
    }

    pub fn count_valid(&self) -> usize {
        self.data.iter().filter(|&&b| b != 0).count()
    }

    pub fn count_null(&self) -> usize {
        self.len() - self.count_valid()
    }

    #[inline]
    pub fn as_slice(&self) -> &[u8] {
        &self.data
    }

    #[inline]
    pub fn as_mut_slice(&mut self) -> &mut [u8] {
        &mut self.data
    }

    pub fn and_mask(&self, other: &NullBitmap) -> NullBitmap {
        assert_eq!(self.len(), other.len(), "Bitmap lengths must match");

        let mut result = AVec::with_capacity(64, self.len());
        result.resize(self.len(), 0u8);

        for ((dst, &a), &b) in result
            .iter_mut()
            .zip(self.data.iter())
            .zip(other.data.iter())
        {
            *dst = a & b;
        }

        NullBitmap { data: result }
    }

    pub fn or_mask(&self, other: &NullBitmap) -> NullBitmap {
        assert_eq!(self.len(), other.len(), "Bitmap lengths must match");

        let mut result = AVec::with_capacity(64, self.len());
        result.resize(self.len(), 0u8);

        for ((dst, &a), &b) in result
            .iter_mut()
            .zip(self.data.iter())
            .zip(other.data.iter())
        {
            *dst = a | b;
        }

        NullBitmap { data: result }
    }

    pub fn not(&self) -> NullBitmap {
        let mut result = AVec::with_capacity(64, self.len());
        result.resize(self.len(), 0u8);

        for (dst, &src) in result.iter_mut().zip(self.data.iter()) {
            *dst = src ^ 1;
        }

        NullBitmap { data: result }
    }

    pub fn gather(&self, indices: &[usize]) -> NullBitmap {
        let mut result = AVec::with_capacity(64, indices.len());
        result.resize(indices.len(), 0u8);

        for (i, &idx) in indices.iter().enumerate() {
            result[i] = self.data[idx];
        }

        NullBitmap { data: result }
    }

    pub fn slice(&self, start: usize, len: usize) -> NullBitmap {
        assert!(start + len <= self.len(), "Slice out of bounds");

        let mut result = AVec::with_capacity(64, len);
        result.resize(len, 0u8);
        result.copy_from_slice(&self.data[start..start + len]);

        NullBitmap { data: result }
    }

    pub fn append(&mut self, other: &NullBitmap) {
        self.data.extend_from_slice(&other.data);
    }

    pub fn reserve(&mut self, additional: usize) {
        self.data.reserve(additional);
    }

    pub fn push(&mut self, is_valid: bool) {
        self.data.push(if is_valid { 1 } else { 0 });
    }

    pub fn remove(&mut self, index: usize) {
        if index < self.data.len() {
            self.data.remove(index);
        }
    }
}

pub struct NullBitmapIter<'a> {
    bitmap: &'a NullBitmap,
    index: usize,
}

impl<'a> Iterator for NullBitmapIter<'a> {
    type Item = bool;

    fn next(&mut self) -> Option<Self::Item> {
        if self.index < self.bitmap.len() {
            let is_valid = self.bitmap.is_valid(self.index);
            self.index += 1;
            Some(is_valid)
        } else {
            None
        }
    }

    fn size_hint(&self) -> (usize, Option<usize>) {
        let remaining = self.bitmap.len() - self.index;
        (remaining, Some(remaining))
    }
}

impl<'a> ExactSizeIterator for NullBitmapIter<'a> {}

impl<'a> IntoIterator for &'a NullBitmap {
    type Item = bool;
    type IntoIter = NullBitmapIter<'a>;

    fn into_iter(self) -> Self::IntoIter {
        NullBitmapIter {
            bitmap: self,
            index: 0,
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_new_valid() {
        let bitmap = NullBitmap::new_valid(10);
        assert_eq!(bitmap.len(), 10);
        assert_eq!(bitmap.count_valid(), 10);
        assert_eq!(bitmap.count_null(), 0);
    }

    #[test]
    fn test_new_null() {
        let bitmap = NullBitmap::new_null(10);
        assert_eq!(bitmap.len(), 10);
        assert_eq!(bitmap.count_valid(), 0);
        assert_eq!(bitmap.count_null(), 10);
    }

    #[test]
    fn test_set_operations() {
        let mut bitmap = NullBitmap::new_valid(5);
        bitmap.set_null(2);
        bitmap.set_null(4);

        assert!(bitmap.is_valid(0));
        assert!(bitmap.is_valid(1));
        assert!(bitmap.is_null(2));
        assert!(bitmap.is_valid(3));
        assert!(bitmap.is_null(4));
    }

    #[test]
    fn test_and_mask() {
        let mut bitmap1 = NullBitmap::new_valid(5);
        bitmap1.set_null(1);
        bitmap1.set_null(3);

        let mut bitmap2 = NullBitmap::new_valid(5);
        bitmap2.set_null(2);
        bitmap2.set_null(3);

        let result = bitmap1.and_mask(&bitmap2);

        assert!(result.is_valid(0));
        assert!(result.is_null(1));
        assert!(result.is_null(2));
        assert!(result.is_null(3));
        assert!(result.is_valid(4));
    }

    #[test]
    fn test_or_mask() {
        let mut bitmap1 = NullBitmap::new_null(5);
        bitmap1.set_valid(1);
        bitmap1.set_valid(3);

        let mut bitmap2 = NullBitmap::new_null(5);
        bitmap2.set_valid(2);
        bitmap2.set_valid(3);

        let result = bitmap1.or_mask(&bitmap2);

        assert!(result.is_null(0));
        assert!(result.is_valid(1));
        assert!(result.is_valid(2));
        assert!(result.is_valid(3));
        assert!(result.is_null(4));
    }

    #[test]
    fn test_slice() {
        let mut bitmap = NullBitmap::new_valid(10);
        bitmap.set_null(3);
        bitmap.set_null(7);

        let sliced = bitmap.slice(2, 5);

        assert_eq!(sliced.len(), 5);
        assert!(sliced.is_null(1));
        assert!(sliced.is_valid(0));
    }

    #[test]
    fn test_iterator() {
        let mut bitmap = NullBitmap::new_valid(5);
        bitmap.set_null(2);

        let validity: Vec<bool> = bitmap.into_iter().collect();
        assert_eq!(validity, vec![true, true, false, true, true]);
    }
}
