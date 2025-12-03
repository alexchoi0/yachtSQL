use std::cell::RefCell;
use std::collections::HashMap;
use std::marker::PhantomData;
use std::rc::Rc;
use std::time::{Duration, Instant};

pub type OperatorId = usize;

pub trait ProfilingMode: Clone {
    const ENABLED: bool;
}

#[derive(Clone, Copy)]
pub struct Disabled;
impl ProfilingMode for Disabled {
    const ENABLED: bool = false;
}

#[derive(Clone, Copy)]
pub struct Enabled;
impl ProfilingMode for Enabled {
    const ENABLED: bool = true;
}

#[derive(Debug, Clone, Default)]
pub struct OperatorMetrics {
    pub rows_produced: usize,
    pub execution_time: Duration,
    pub peak_memory_bytes: Option<usize>,
    pub num_batches: usize,
    pub custom_metrics: HashMap<String, MetricValue>,
}

#[derive(Debug, Clone)]
pub enum MetricValue {
    Count(usize),
    Bytes(usize),
    Percentage(f64),
    Duration(Duration),
}

impl std::fmt::Display for MetricValue {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match self {
            MetricValue::Count(n) => write!(f, "{}", n),
            MetricValue::Bytes(b) => {
                if *b < 1024 {
                    write!(f, "{} B", b)
                } else if *b < 1024 * 1024 {
                    write!(f, "{:.2} KB", *b as f64 / 1024.0)
                } else {
                    write!(f, "{:.2} MB", *b as f64 / (1024.0 * 1024.0))
                }
            }
            MetricValue::Percentage(p) => write!(f, "{:.1}%", p),
            MetricValue::Duration(d) => write!(f, "{:.2}ms", d.as_secs_f64() * 1000.0),
        }
    }
}

#[derive(Clone)]
pub struct QueryProfiler<M: ProfilingMode> {
    metrics: Rc<RefCell<HashMap<OperatorId, OperatorMetrics>>>,
    _mode: PhantomData<M>,
}

impl<M: ProfilingMode> QueryProfiler<M> {
    #[inline(always)]
    pub fn new() -> Self {
        Self {
            metrics: Rc::new(RefCell::new(HashMap::new())),
            _mode: PhantomData,
        }
    }

    #[inline(always)]
    pub const fn is_enabled(&self) -> bool {
        M::ENABLED
    }

    #[inline(always)]
    pub fn start_operator(&self, operator_id: OperatorId) -> OperatorTimer<M> {
        OperatorTimer {
            profiler: self.clone(),
            operator_id,
            start: if M::ENABLED {
                Some(Instant::now())
            } else {
                None
            },
            recorded: false,
        }
    }

    #[inline(always)]
    pub fn record_batch(&self, operator_id: OperatorId, num_rows: usize, elapsed: Duration) {
        if M::ENABLED {
            let mut metrics = self.metrics.borrow_mut();
            let entry = metrics.entry(operator_id).or_default();
            entry.rows_produced += num_rows;
            entry.execution_time += elapsed;
            entry.num_batches += 1;
        }
    }

    #[inline(always)]
    pub fn record_custom_metric(&self, operator_id: OperatorId, name: String, value: MetricValue) {
        if M::ENABLED {
            let mut metrics = self.metrics.borrow_mut();
            let entry = metrics.entry(operator_id).or_default();
            entry.custom_metrics.insert(name, value);
        }
    }

    pub fn get_metrics(&self, operator_id: OperatorId) -> Option<OperatorMetrics> {
        if M::ENABLED {
            self.metrics.borrow().get(&operator_id).cloned()
        } else {
            None
        }
    }

    pub fn get_all_metrics(&self) -> HashMap<OperatorId, OperatorMetrics> {
        if M::ENABLED {
            self.metrics.borrow().clone()
        } else {
            HashMap::new()
        }
    }

    pub fn reset(&self) {
        if M::ENABLED {
            self.metrics.borrow_mut().clear();
        }
    }
}

pub struct OperatorTimer<M: ProfilingMode> {
    profiler: QueryProfiler<M>,
    operator_id: OperatorId,
    start: Option<Instant>,
    recorded: bool,
}

impl<M: ProfilingMode> OperatorTimer<M> {
    #[inline(always)]
    pub fn record_batch(&mut self, num_rows: usize) {
        if M::ENABLED {
            if let Some(start) = self.start {
                let elapsed = start.elapsed();
                self.profiler
                    .record_batch(self.operator_id, num_rows, elapsed);
                self.recorded = true;
            }
        }
    }

    #[inline(always)]
    pub fn record_custom(&self, name: String, value: MetricValue) {
        if M::ENABLED {
            self.profiler
                .record_custom_metric(self.operator_id, name, value);
        }
    }
}

impl<M: ProfilingMode> Drop for OperatorTimer<M> {
    #[inline(always)]
    fn drop(&mut self) {
        if M::ENABLED && !self.recorded {
            if let Some(start) = self.start {
                let elapsed = start.elapsed();
                self.profiler.record_batch(self.operator_id, 0, elapsed);
            }
        }
    }
}

pub type ProfilerDisabled = QueryProfiler<Disabled>;
pub type ProfilerEnabled = QueryProfiler<Enabled>;

#[cfg(test)]
mod tests {
    use std::thread;
    use std::time::Duration;

    use super::*;

    #[test]
    fn test_profiler_enabled() {
        let profiler = QueryProfiler::<Enabled>::new();

        {
            let mut timer = profiler.start_operator(1);
            thread::sleep(Duration::from_millis(10));
            timer.record_batch(100);
        }

        let metrics = profiler.get_metrics(1).unwrap();
        assert_eq!(metrics.rows_produced, 100);
        assert_eq!(metrics.num_batches, 1);
        assert!(metrics.execution_time.as_millis() >= 10);
    }

    #[test]
    fn test_profiler_disabled() {
        let profiler = QueryProfiler::<Disabled>::new();

        {
            let mut timer = profiler.start_operator(1);
            timer.record_batch(100);
        }

        assert!(profiler.get_metrics(1).is_none());
    }

    #[test]
    fn test_type_aliases() {
        let _disabled = ProfilerDisabled::new();
        let _enabled = ProfilerEnabled::new();
    }
}
