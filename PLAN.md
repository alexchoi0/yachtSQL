# Worker 4: Interval Functions

## Objective
Implement interval-related functions to remove `#[ignore]` tags from `tests/postgresql/data_types/interval.rs`.

## Test File
- `tests/postgresql/data_types/interval.rs` (8 ignored tests)

## Features to Implement

### 1. Date + Interval Arithmetic
- `DATE '2024-01-01' + INTERVAL '5 days'` - Add interval to date
- Returns DATE or TIMESTAMP depending on interval components

### 2. EXTRACT from Interval
- `EXTRACT(DAY FROM INTERVAL '5 days 3 hours')` → 5
- `EXTRACT(HOUR FROM INTERVAL '5 days 3 hours')` → 3
- Support: YEAR, MONTH, DAY, HOUR, MINUTE, SECOND

### 3. ISO 8601 Interval Format
- `INTERVAL 'P1Y2M3D'` - ISO 8601 duration format
- P = Period, Y = Years, M = Months, D = Days
- T prefix for time: `PT1H30M` = 1 hour 30 minutes

### 4. AGE Function
- `AGE(timestamp1, timestamp2)` - Difference as interval
- `AGE(timestamp)` - Difference from current_date
- Returns interval with years, months, days, etc.

### 5. JUSTIFY Functions
- `JUSTIFY_DAYS(interval)` - Convert 30-day periods to months
- `JUSTIFY_HOURS(interval)` - Convert 24-hour periods to days
- `JUSTIFY_INTERVAL(interval)` - Apply both justifications

## Implementation Steps

1. **Date + Interval**
   - Parse DATE literal if not already supported
   - Add interval to date, handling day/month/year overflow
   - Return appropriate result type

2. **EXTRACT for Intervals**
   - Extend EXTRACT function to handle interval input
   - Extract specific component from interval struct
   - Handle field extraction logic

3. **ISO 8601 Parsing**
   - Detect ISO format (starts with 'P')
   - Parse designators: Y, M, W, D, T, H, M, S
   - Convert to internal interval representation

4. **AGE Function**
   - Register AGE as scalar function
   - Two-argument: compute interval between timestamps
   - One-argument: use CURRENT_DATE as reference
   - Calculate years, months, days difference

5. **JUSTIFY Functions**
   - `JUSTIFY_HOURS`: hours >= 24 → add days
   - `JUSTIFY_DAYS`: days >= 30 → add months
   - `JUSTIFY_INTERVAL`: apply both, handle signs

## Key Files to Modify
- `crates/parser/src/` - ISO 8601 interval parsing
- `crates/executor/src/query_executor/evaluator/` - Function implementations
- Interval type arithmetic handlers

## Testing
```bash
cargo test --test postgresql data_types::interval
```

## Notes
- Basic interval operations (arithmetic, comparison) already work
- Focus on the specific functions and date+interval arithmetic
