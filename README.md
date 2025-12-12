# YachtSQL

A lightweight, embeddable SQL database engine with columnar storage for Rust applications. YachtSQL provides multi-dialect SQL support for PostgreSQL, BigQuery, and ClickHouse, making it ideal for testing, prototyping, and embedded analytics.

## Features

- **Multi-Dialect SQL** - Native support for PostgreSQL, BigQuery, and ClickHouse SQL syntax
- **Columnar Storage** - High-performance columnar engine optimized for analytical queries
- **MVCC Transactions** - Full ACID transaction support with snapshot isolation
- **Query Optimization** - Rule-based optimizer with predicate pushdown, projection pruning, and subquery flattening
- **Advanced SQL** - CTEs (recursive), window functions, lateral joins, PIVOT/UNPIVOT, set operations
- **Rich Type System** - 50+ data types including arrays, structs, JSON, ranges, network types, and geometry

## Requirements

- Rust nightly (edition 2024)

## Installation

Add YachtSQL to your `Cargo.toml`:

```toml
[dependencies]
yachtsql = { git = "https://github.com/alexchoi0/YachtSQL" }
```

## Quick Start

```rust
use yachtsql::{QueryExecutor, DialectType};

fn main() -> yachtsql::Result<()> {
    // Create executor with PostgreSQL dialect
    let mut executor = QueryExecutor::new_with_dialect(DialectType::PostgreSQL);

    // Create a table
    executor.execute_sql("
        CREATE TABLE users (
            id SERIAL PRIMARY KEY,
            name TEXT NOT NULL,
            email TEXT,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )
    ")?;

    // Insert data
    executor.execute_sql("
        INSERT INTO users (name, email) VALUES
            ('Alice', 'alice@example.com'),
            ('Bob', 'bob@example.com')
    ")?;

    // Query with window functions
    let results = executor.execute_sql("
        SELECT
            name,
            ROW_NUMBER() OVER (ORDER BY created_at) as row_num
        FROM users
    ")?;

    println!("{:?}", results);
    Ok(())
}
```

### BigQuery Dialect

```rust
let mut executor = QueryExecutor::new_with_dialect(DialectType::BigQuery);

executor.execute_sql("
    SELECT
        ARRAY_AGG(name) as names,
        STRUCT(COUNT(*) as total, AVG(score) as avg_score) as stats
    FROM users
    GROUP BY department
")?;
```

### ClickHouse Dialect

```rust
let mut executor = QueryExecutor::new_with_dialect(DialectType::ClickHouse);

// Create MergeTree table
executor.execute_sql("
    CREATE TABLE events (
        event_date Date,
        user_id UInt64,
        event_type String
    ) ENGINE = MergeTree()
    ORDER BY (event_date, user_id)
")?;

// Use ClickHouse-specific functions
executor.execute_sql("
    SELECT
        toStartOfMonth(event_date) as month,
        uniqExact(user_id) as unique_users
    FROM events
    GROUP BY month
")?;
```

## Supported Data Types

| Category | Types |
|----------|-------|
| Numeric | `INT64`, `FLOAT32`, `FLOAT64`, `NUMERIC/DECIMAL`, `SERIAL`, `BIGSERIAL` |
| Text | `STRING`, `TEXT`, `BYTES`, `FIXEDSTRING(N)` |
| Boolean | `BOOLEAN` |
| Temporal | `DATE`, `TIME`, `TIMESTAMP`, `TIMESTAMPTZ`, `INTERVAL` |
| Complex | `ARRAY<T>`, `STRUCT`, `MAP<K,V>`, `JSON`, `HSTORE` |
| Network | `INET`, `CIDR`, `MACADDR`, `IPv4`, `IPv6` |
| Geometric | `POINT`, `LINE`, `POLYGON`, `CIRCLE`, `BOX`, `PATH` |
| Range | `INT4RANGE`, `INT8RANGE`, `NUMRANGE`, `TSRANGE`, `DATERANGE` |
| Other | `UUID`, `ENUM`, `VECTOR(N)`, `GEOGRAPHY` |

## ClickHouse Table Engines

| Engine | Description |
|--------|-------------|
| `MergeTree` | Primary OLAP engine with sorting and partitioning |
| `ReplacingMergeTree` | Deduplication by sorting key |
| `SummingMergeTree` | Automatic aggregation of numeric columns |
| `AggregatingMergeTree` | Pre-aggregation with State/Merge functions |
| `CollapsingMergeTree` | Row collapsing with sign column |
| `Log` / `TinyLog` / `StripeLog` | Simple append-only storage |
| `Memory` | In-memory storage |
| `Buffer` | Buffered writes to destination table |
| `Distributed` | Distributed query execution |
| `Null` / `Set` / `Merge` | Special-purpose engines |

## SQL Features

### Query Capabilities
- **Joins**: INNER, LEFT, RIGHT, FULL, CROSS, LATERAL, ASOF (ClickHouse)
- **Subqueries**: Scalar, EXISTS, IN, correlated subqueries
- **CTEs**: WITH clause, recursive CTEs
- **Window Functions**: ROW_NUMBER, RANK, DENSE_RANK, LAG, LEAD, FIRST_VALUE, LAST_VALUE, NTH_VALUE
- **Aggregations**: Standard aggregates + dialect-specific (quantile, uniq, groupArray, etc.)
- **Set Operations**: UNION, INTERSECT, EXCEPT (with ALL/DISTINCT)

### DDL Support
- CREATE/DROP/ALTER TABLE
- CREATE/DROP VIEW, MATERIALIZED VIEW
- CREATE/DROP INDEX
- Table partitioning (PostgreSQL, BigQuery)
- Table constraints (PRIMARY KEY, FOREIGN KEY, UNIQUE, CHECK)

### DML Support
- INSERT (single row, multi-row, INSERT...SELECT)
- UPDATE with complex expressions
- DELETE with subqueries
- MERGE/UPSERT
- TRUNCATE

## Project Structure

```
yachtsql/
├── crates/
│   ├── core/           # Core types, errors, value representation
│   ├── storage/        # Columnar storage, schemas, indexes, MVCC
│   ├── parser/         # Multi-dialect SQL parsing
│   ├── ir/             # Intermediate representation (logical plan)
│   ├── optimizer/      # Query optimization rules
│   ├── executor/       # Physical execution engine
│   ├── functions/      # 500+ SQL function implementations
│   ├── capability/     # SQL feature registry
│   ├── dialects/       # Dialect-specific behavior
│   └── test-utils/     # Testing utilities and macros
├── tests/              # 5,200+ integration tests
│   ├── bigquery/
│   ├── clickhouse/
│   └── postgresql/
└── benches/            # Performance benchmarks
```

## Building

```bash
# Build all crates
cargo build

# Build optimized release
cargo build --release

# Check without building
cargo check
```

## Testing

```bash
# Run all tests (uses cargo-nextest)
cargo nextest run

# Run tests for specific dialect
cargo nextest run --test postgresql
cargo nextest run --test bigquery
cargo nextest run --test clickhouse

# Run specific test
cargo nextest run test_window_functions
```

## Benchmarks

```bash
# Run all benchmarks
cargo bench

# Run specific benchmark suite
cargo bench --bench clickhouse
cargo bench --bench bigquery
```

## License

MIT OR Apache-2.0
