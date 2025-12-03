pub mod sort;

#[derive(Debug)]
pub struct ExecutionContext {}

impl ExecutionContext {
    pub fn new() -> Self {
        Self {}
    }
}

impl Default for ExecutionContext {
    fn default() -> Self {
        Self::new()
    }
}
