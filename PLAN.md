# Worker 6: Bytea Functions

## Objective
Implement bytea (binary) functions to remove `#[ignore]` tags from `tests/postgresql/data_types/bytes.rs`.

## Test File
- `tests/postgresql/data_types/bytes.rs` (9 ignored tests)

## Features to Implement

### 1. Escape String Literal
- `E'\\x48656c6c6f'::BYTEA` - Escape string format
- Handle backslash escaping in E'' strings

### 2. LENGTH for Bytea
- `LENGTH(bytea)` - Return length in bytes
- Distinct from character length for text

### 3. SUBSTRING for Bytea
- `SUBSTRING(bytea, start, length)` - Extract bytes
- 1-indexed positioning
- Handle out-of-bounds gracefully

### 4. POSITION for Bytea
- `POSITION(pattern IN bytea)` - Find byte sequence
- Return 1-indexed position or 0 if not found

### 5. OCTET_LENGTH for Bytea
- `OCTET_LENGTH(bytea)` - Same as LENGTH for bytea
- Explicit byte count function

### 6. ENCODE Function
- `ENCODE(bytea, 'base64')` - Encode to base64 string
- `ENCODE(bytea, 'hex')` - Encode to hex string
- `ENCODE(bytea, 'escape')` - PostgreSQL escape format

### 7. DECODE Function
- `DECODE('SGVsbG8=', 'base64')` - Decode from base64
- `DECODE('48656c6c6f', 'hex')` - Decode from hex
- `DECODE(string, 'escape')` - Decode escape format

## Implementation Steps

1. **Escape String Parsing**
   - Handle `E'...'` string literals
   - Process `\\x` hex escape sequences
   - Process `\\` and other escape sequences

2. **LENGTH/OCTET_LENGTH**
   - Register functions for bytea type
   - Return byte count (not character count)
   - Overload or type-check existing LENGTH

3. **SUBSTRING for Bytea**
   - Extend SUBSTRING to handle bytea input
   - Byte-based indexing (not character)
   - Return bytea result

4. **POSITION for Bytea**
   - Extend POSITION to handle bytea operands
   - Byte sequence matching
   - Return integer position

5. **ENCODE Function**
   - Register ENCODE(bytea, text) function
   - Implement base64 encoding (use base64 crate)
   - Implement hex encoding
   - Implement escape encoding

6. **DECODE Function**
   - Register DECODE(text, text) function
   - Implement base64 decoding
   - Implement hex decoding
   - Handle invalid input gracefully

## Key Files to Modify
- `crates/parser/src/` - E-string literal handling
- `crates/executor/src/query_executor/evaluator/` - Function implementations

## Dependencies
Consider adding to Cargo.toml:
```toml
base64 = "0.21"  # For base64 encode/decode
```

## Testing
```bash
cargo test --test postgresql data_types::bytes
```

## Notes
- Basic bytea literals and concatenation already work
- Focus on the function implementations
- Ensure type dispatch distinguishes bytea from text
