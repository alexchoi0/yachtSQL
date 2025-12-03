# Project Instructions for Claude Code

1. Don't simply put `#[ignore]` on failing tests.
   When a test fails because a feature is not yet implemented, implement the missing feature rather than adding
   `#[ignore]` to skip the test. The test exists to drive the implementation - skipping it defeats the purpose of TDD.

2. Use `debug_eprintln!` instead of `eprintln!`. Use headers such as `debug_eprintln!("[executor::dml::insert] ..");` on
   executor/dml/insert.rs.

3. Do not blatantly panic in rust. Propagate errors to top and gracefully handle errors.

4. Do not write comments unless instructed. Simply write code.

5. Match all enum variants explicitly and exhaustively.