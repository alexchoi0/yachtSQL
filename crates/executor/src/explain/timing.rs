use std::time::Duration;
#[cfg(any(
    not(any(target_arch = "x86_64", target_arch = "aarch64")),
    test,
    target_arch = "x86_64"
))]
use std::time::Instant;

#[derive(Copy, Clone, Debug)]
pub struct FastTimestamp {
    #[cfg(target_arch = "x86_64")]
    cycles: u64,

    #[cfg(target_arch = "aarch64")]
    cycles: u64,

    #[cfg(not(any(target_arch = "x86_64", target_arch = "aarch64")))]
    instant: Instant,
}

impl FastTimestamp {
    #[inline(always)]
    pub fn now() -> Self {
        #[cfg(target_arch = "x86_64")]
        {
            Self {
                cycles: unsafe { core::arch::x86_64::_rdtsc() },
            }
        }

        #[cfg(target_arch = "aarch64")]
        {
            Self {
                cycles: read_cntvct(),
            }
        }

        #[cfg(not(any(target_arch = "x86_64", target_arch = "aarch64")))]
        {
            Self {
                instant: Instant::now(),
            }
        }
    }

    #[inline(always)]
    pub fn elapsed(self) -> Duration {
        #[cfg(target_arch = "x86_64")]
        {
            let end_cycles = unsafe { core::arch::x86_64::_rdtsc() };
            let elapsed_cycles = end_cycles.saturating_sub(self.cycles);
            cycles_to_duration_x86(elapsed_cycles)
        }

        #[cfg(target_arch = "aarch64")]
        {
            let end_cycles = read_cntvct();
            let elapsed_cycles = end_cycles.saturating_sub(self.cycles);
            cycles_to_duration_arm64(elapsed_cycles)
        }

        #[cfg(not(any(target_arch = "x86_64", target_arch = "aarch64")))]
        {
            self.instant.elapsed()
        }
    }
}

#[cfg(target_arch = "aarch64")]
#[inline(always)]
fn read_cntvct() -> u64 {
    let count: u64;
    unsafe {
        std::arch::asm!(
            "mrs {}, cntvct_el0",
            out(reg) count,
            options(nostack, nomem)
        );
    }
    count
}

#[cfg(target_arch = "aarch64")]
#[inline(always)]
fn read_cntfrq() -> u64 {
    let freq: u64;
    unsafe {
        std::arch::asm!(
            "mrs {}, cntfrq_el0",
            out(reg) freq,
            options(nostack, nomem)
        );
    }
    freq
}

#[cfg(target_arch = "aarch64")]
#[inline(always)]
fn cycles_to_duration_arm64(cycles: u64) -> Duration {
    let freq = read_cntfrq();

    let nanos = ((cycles as u128) * 1_000_000_000) / (freq as u128);
    Duration::from_nanos(nanos as u64)
}

#[cfg(target_arch = "x86_64")]
#[inline(always)]
fn cycles_to_duration_x86(cycles: u64) -> Duration {
    const CYCLES_PER_NS: f64 = 2.5;
    let nanos = (cycles as f64 / CYCLES_PER_NS) as u64;
    Duration::from_nanos(nanos)
}

#[cfg(target_arch = "x86_64")]
pub fn calibrate_cpu_frequency() -> f64 {
    use std::thread;

    let start_instant = Instant::now();
    let start_cycles = unsafe { core::arch::x86_64::_rdtsc() };

    thread::sleep(Duration::from_millis(10));

    let end_cycles = unsafe { core::arch::x86_64::_rdtsc() };
    let end_instant = Instant::now();

    let elapsed_time = end_instant.duration_since(start_instant);
    let elapsed_cycles = end_cycles - start_cycles;

    let freq_hz = elapsed_cycles as f64 / elapsed_time.as_secs_f64();
    freq_hz / 1_000_000.0
}

#[cfg(target_arch = "aarch64")]
pub fn get_counter_frequency() -> f64 {
    let freq_hz = read_cntfrq() as f64;
    freq_hz / 1_000_000.0
}

#[cfg(test)]
mod tests {
    use std::thread;

    use super::*;

    #[test]
    fn test_fast_timestamp() {
        let start = FastTimestamp::now();
        thread::sleep(Duration::from_millis(10));
        let elapsed = start.elapsed();

        assert!(
            elapsed.as_millis() >= 10,
            "Expected >= 10ms, got {:?}",
            elapsed
        );

        assert!(
            elapsed.as_millis() < 20,
            "Expected < 20ms, got {:?}",
            elapsed
        );
    }

    #[test]
    fn test_fast_timestamp_precision() {
        let ts1 = FastTimestamp::now();

        let mut sum = 0u64;
        for i in 0..1000 {
            sum = sum.wrapping_add(i);
        }

        let ts2 = FastTimestamp::now();

        assert!(sum > 0);

        let elapsed1 = ts1.elapsed();

        let elapsed2 = ts2.elapsed();

        assert!(elapsed1.as_nanos() >= elapsed2.as_nanos());
    }

    #[cfg(target_arch = "x86_64")]
    #[test]
    fn test_cpu_frequency_calibration() {
        let freq_mhz = calibrate_cpu_frequency();

        assert!(freq_mhz > 1000.0, "CPU frequency too low: {} MHz", freq_mhz);
        assert!(
            freq_mhz < 10000.0,
            "CPU frequency too high: {} MHz",
            freq_mhz
        );

        println!("Detected CPU frequency: {:.2} MHz", freq_mhz);
    }

    #[cfg(target_arch = "aarch64")]
    #[test]
    fn test_counter_frequency() {
        let freq_mhz = get_counter_frequency();

        assert!(
            freq_mhz > 10.0,
            "Counter frequency too low: {} MHz",
            freq_mhz
        );
        assert!(
            freq_mhz < 2000.0,
            "Counter frequency too high: {} MHz",
            freq_mhz
        );

        println!("ARM64 counter frequency: {:.2} MHz", freq_mhz);
    }
}
