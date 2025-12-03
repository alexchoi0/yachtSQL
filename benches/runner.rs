use criterion::criterion_main;

mod aggregations;
mod basic_operations;
mod complex_queries;
mod data_types;
mod functions;
mod joins;
mod merge;
mod optimizer;
mod scalability;

criterion_main! {
    basic_operations::benches,
    aggregations::benches,
    joins::benches,
    functions::benches,
    complex_queries::benches,
    data_types::benches,
    optimizer::benches,
    scalability::benches,
    merge::benches,
}
