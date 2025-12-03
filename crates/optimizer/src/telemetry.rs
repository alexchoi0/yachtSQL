use std::collections::HashMap;
use std::time::{Duration, Instant};

use serde::Serialize;

use crate::phase::Phase;

#[derive(Debug, Clone)]
pub struct RuleStats {
    pub name: String,

    pub invocations: usize,

    pub applications: usize,

    pub total_time: Duration,

    pub min_time: Duration,

    pub max_time: Duration,
}

impl RuleStats {
    pub fn new(name: String) -> Self {
        Self {
            name,
            invocations: 0,
            applications: 0,
            total_time: Duration::ZERO,
            min_time: Duration::MAX,
            max_time: Duration::ZERO,
        }
    }

    pub fn record_invocation(&mut self, duration: Duration, applied: bool) {
        self.invocations += 1;
        if applied {
            self.applications += 1;
        }

        self.total_time += duration;
        self.min_time = self.min_time.min(duration);
        self.max_time = self.max_time.max(duration);
    }

    pub fn avg_time(&self) -> Duration {
        if self.invocations == 0 {
            Duration::ZERO
        } else {
            self.total_time / self.invocations as u32
        }
    }

    pub fn success_rate(&self) -> f64 {
        if self.invocations == 0 {
            0.0
        } else {
            self.applications as f64 / self.invocations as f64
        }
    }

    pub fn is_ineffective(&self) -> bool {
        self.invocations > 0 && self.applications == 0
    }
}

#[derive(Debug, Clone)]
pub struct PhaseStats {
    pub phase: Phase,

    pub iterations: usize,

    pub total_time: Duration,
}

impl PhaseStats {
    pub fn new(phase: Phase) -> Self {
        Self {
            phase,
            iterations: 0,
            total_time: Duration::ZERO,
        }
    }

    pub fn record_iteration(&mut self) {
        self.iterations += 1;
    }

    pub fn record_time(&mut self, duration: Duration) {
        self.total_time += duration;
    }
}

#[derive(Debug, Serialize)]
pub struct RuleSnapshot {
    pub name: String,

    pub phase: String,

    pub invocations: usize,

    pub applications: usize,

    pub total_time_ns: u128,

    pub avg_time_ns: u128,
}

#[derive(Debug, Serialize)]
pub struct PhaseSnapshot {
    pub name: String,

    pub iterations: usize,

    pub total_time_ns: u128,
}

#[derive(Debug, Serialize)]
pub struct TelemetrySnapshot {
    pub enabled: bool,

    pub total_iterations: usize,

    pub total_time_ns: u128,

    pub phases: Vec<PhaseSnapshot>,

    pub rules: Vec<RuleSnapshot>,
}

#[derive(Debug, Clone)]
pub struct OptimizerTelemetry {
    rule_stats: HashMap<String, RuleStats>,

    rule_phase: HashMap<String, Phase>,

    phase_stats: HashMap<Phase, PhaseStats>,

    iterations: usize,

    total_time: Duration,

    enabled: bool,
}

impl OptimizerTelemetry {
    pub fn new(enabled: bool) -> Self {
        let mut phase_stats = HashMap::new();
        for phase in Phase::all() {
            phase_stats.insert(phase, PhaseStats::new(phase));
        }

        Self {
            rule_stats: HashMap::new(),
            rule_phase: HashMap::new(),
            phase_stats,
            iterations: 0,
            total_time: Duration::ZERO,
            enabled,
        }
    }

    pub fn is_enabled(&self) -> bool {
        self.enabled
    }

    pub fn start_iteration(&mut self) {
        if self.enabled {
            self.iterations += 1;
        }
    }

    pub fn record_total_time(&mut self, duration: Duration) {
        if self.enabled {
            self.total_time = duration;
        }
    }

    pub fn record_rule(
        &mut self,
        phase: Phase,
        rule_name: &str,
        duration: Duration,
        applied: bool,
    ) {
        if !self.enabled {
            return;
        }

        self.rule_stats
            .entry(rule_name.to_string())
            .or_insert_with(|| RuleStats::new(rule_name.to_string()))
            .record_invocation(duration, applied);

        self.rule_phase.insert(rule_name.to_string(), phase);
    }

    pub fn record_phase_iteration(&mut self, phase: Phase) {
        if !self.enabled {
            return;
        }
        if let Some(stats) = self.phase_stats.get_mut(&phase) {
            stats.record_iteration();
        }
    }

    pub fn record_phase_time(&mut self, phase: Phase, duration: Duration) {
        if !self.enabled {
            return;
        }
        if let Some(stats) = self.phase_stats.get_mut(&phase) {
            stats.record_time(duration);
        }
    }

    pub fn phase_stats(&self, phase: Phase) -> Option<&PhaseStats> {
        self.phase_stats.get(&phase)
    }

    pub fn all_phase_stats(&self) -> Vec<&PhaseStats> {
        let mut stats: Vec<_> = self.phase_stats.values().collect();
        stats.sort_by_key(|s| s.phase);
        stats
    }

    pub fn total_iterations(&self) -> usize {
        self.iterations
    }

    pub fn total_time(&self) -> Duration {
        self.total_time
    }

    pub fn snapshot(&self) -> TelemetrySnapshot {
        let phases = self
            .all_phase_stats()
            .into_iter()
            .map(|stats| PhaseSnapshot {
                name: stats.phase.name().to_string(),
                iterations: stats.iterations,
                total_time_ns: stats.total_time.as_nanos(),
            })
            .collect();

        let mut rules: Vec<_> = self
            .rule_stats
            .iter()
            .map(|(name, stats)| RuleSnapshot {
                name: name.clone(),
                phase: self
                    .rule_phase
                    .get(name)
                    .map(|p| p.name().to_string())
                    .unwrap_or_else(|| "Unknown".to_string()),
                invocations: stats.invocations,
                applications: stats.applications,
                total_time_ns: stats.total_time.as_nanos(),
                avg_time_ns: stats.avg_time().as_nanos(),
            })
            .collect();
        rules.sort_by_key(|r| std::cmp::Reverse(r.total_time_ns));

        TelemetrySnapshot {
            enabled: self.enabled,
            total_iterations: self.iterations,
            total_time_ns: self.total_time.as_nanos(),
            phases,
            rules,
        }
    }

    pub fn all_rule_stats(&self) -> Vec<&RuleStats> {
        self.rule_stats.values().collect()
    }

    pub fn rule_stats(&self, name: &str) -> Option<&RuleStats> {
        self.rule_stats.get(name)
    }

    pub fn slowest_rule(&self) -> Option<&RuleStats> {
        self.rule_stats.values().max_by_key(|s| s.total_time)
    }

    pub fn most_applied_rule(&self) -> Option<&RuleStats> {
        self.rule_stats.values().max_by_key(|s| s.applications)
    }

    pub fn ineffective_rules(&self) -> Vec<&RuleStats> {
        self.rule_stats
            .values()
            .filter(|s| s.is_ineffective())
            .collect()
    }

    pub fn summary(&self) -> String {
        if !self.enabled {
            return "Telemetry disabled".to_string();
        }

        let mut output = String::new();
        output.push_str("Optimizer Telemetry Summary\n");
        output.push_str("===========================\n");
        output.push_str(&format!("Total iterations: {}\n", self.iterations));
        output.push_str(&format!("Total time: {:?}\n", self.total_time));
        output.push_str(&format!("Rules tracked: {}\n\n", self.rule_stats.len()));

        let mut sorted_rules: Vec<_> = self.rule_stats.values().collect();
        sorted_rules.sort_by_key(|s| std::cmp::Reverse(s.total_time));

        output.push_str("Rules by total time:\n");
        for (i, stats) in sorted_rules.iter().enumerate().take(10) {
            output.push_str(&format!(
                "  {}. {} - {:?} ({} apps / {} invocations = {:.1}%)\n",
                i + 1,
                stats.name,
                stats.total_time,
                stats.applications,
                stats.invocations,
                stats.success_rate() * 100.0
            ));
        }

        let ineffective = self.ineffective_rules();
        if !ineffective.is_empty() {
            output.push_str(&format!("\nIneffective rules ({}):\n", ineffective.len()));
            for stats in ineffective {
                output.push_str(&format!(
                    "  - {} ({} invocations)\n",
                    stats.name, stats.invocations
                ));
            }
        }

        output.push_str("\nPhase breakdown:\n");
        for phase in Phase::all() {
            if let Some(stats) = self.phase_stats.get(&phase) {
                output.push_str(&format!(
                    "  - {}: {:?} total, {} iterations\n",
                    phase.name(),
                    stats.total_time,
                    stats.iterations
                ));

                let mut phase_rules: Vec<_> = self
                    .rule_stats
                    .iter()
                    .filter(|(name, _)| self.rule_phase.get(*name) == Some(&phase))
                    .map(|(_, stats)| stats)
                    .collect();
                phase_rules.sort_by_key(|s| std::cmp::Reverse(s.total_time));

                for rule in phase_rules.iter().take(3) {
                    output.push_str(&format!(
                        "      • {} — {:?} ({} apps / {} invocations)\n",
                        rule.name, rule.total_time, rule.applications, rule.invocations
                    ));
                }
            }
        }

        output
    }

    pub fn clear(&mut self) {
        self.rule_stats.clear();
        self.rule_phase.clear();
        self.iterations = 0;
        self.total_time = Duration::ZERO;
        self.phase_stats.clear();
        for phase in Phase::all() {
            self.phase_stats.insert(phase, PhaseStats::new(phase));
        }
    }
}

impl Default for OptimizerTelemetry {
    fn default() -> Self {
        Self::new(false)
    }
}

pub struct RuleTimer {
    start: Instant,
}

impl RuleTimer {
    pub fn start() -> Self {
        Self {
            start: Instant::now(),
        }
    }

    pub fn stop(self) -> Duration {
        self.start.elapsed()
    }
}
