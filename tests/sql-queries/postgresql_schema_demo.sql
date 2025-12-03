-- PostgreSQL Schema Demo
-- This script demonstrates all supported PostgreSQL DDL features in yachtsql
-- Run with: cargo test --test postgresql_schema_demo --features tdd-tests

-- ============================================================================
-- 1. CREATE EXTENSION (for UUID generation functions)
-- ============================================================================

-- Enable pgcrypto extension for gen_random_uuid()
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- ============================================================================
-- 2. USERS TABLE
--    Features: UUID, gen_random_uuid(), TIMESTAMP WITH TIME ZONE,
--              CURRENT_TIMESTAMP, UNIQUE, NOT NULL, CHECK constraint
-- ============================================================================

CREATE TABLE IF NOT EXISTS users (
    -- UUID primary key with auto-generation
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    -- Email with uniqueness constraint
    email VARCHAR(255) NOT NULL UNIQUE,

    -- Optional profile fields
    name VARCHAR(255),
    avatar_url TEXT,

    -- Authentication fields
    password_hash TEXT,
    provider VARCHAR(50),
    provider_user_id TEXT,

    -- Timestamps with timezone support
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,

    -- Named CHECK constraint for OAuth validation
    CONSTRAINT oauth_user_check CHECK (
        (provider = 'email' AND password_hash IS NOT NULL) OR
        (provider IN ('google', 'microsoft', 'apple') AND provider_user_id IS NOT NULL)
    )
);

-- Indexes for user lookups
CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);
CREATE INDEX IF NOT EXISTS idx_users_provider ON users(provider, provider_user_id);

-- ============================================================================
-- 3. REFRESH TOKENS TABLE
--    Features: Foreign key with ON DELETE CASCADE, complex CHECK constraint
-- ============================================================================

CREATE TABLE IF NOT EXISTS refresh_tokens (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    -- Foreign key to users with cascade delete
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,

    -- Token storage (hashed)
    token_hash VARCHAR(255) NOT NULL UNIQUE,

    -- Token lifecycle
    expires_at TIMESTAMP WITH TIME ZONE NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    revoked_at TIMESTAMP WITH TIME ZONE,

    -- Ensure token is either active or revoked
    CONSTRAINT token_state_check CHECK (
        (revoked_at IS NULL AND expires_at > CURRENT_TIMESTAMP) OR
        (revoked_at IS NOT NULL)
    )
);

-- Indexes for token operations
CREATE INDEX IF NOT EXISTS idx_refresh_tokens_user_id ON refresh_tokens(user_id);
CREATE INDEX IF NOT EXISTS idx_refresh_tokens_token_hash ON refresh_tokens(token_hash);
CREATE INDEX IF NOT EXISTS idx_refresh_tokens_expires_at ON refresh_tokens(expires_at);

-- ============================================================================
-- 4. CONVERSATIONS TABLE
--    Features: Foreign key reference, TIMESTAMPTZ shorthand
-- ============================================================================

CREATE TABLE IF NOT EXISTS conversations (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    title VARCHAR(255),
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_conversations_user_id ON conversations(user_id);

-- ============================================================================
-- 5. MESSAGES TABLE
--    Features: Inline CHECK constraint with IN clause
-- ============================================================================

CREATE TABLE IF NOT EXISTS messages (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    conversation_id UUID NOT NULL REFERENCES conversations(id) ON DELETE CASCADE,

    -- Role validation using CHECK with IN
    role VARCHAR(50) NOT NULL CHECK (role IN ('user', 'assistant', 'system')),

    content TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_messages_conversation_id ON messages(conversation_id);

-- ============================================================================
-- 6. REACTIONS TABLE
--    Features: Multi-column UNIQUE constraint
-- ============================================================================

CREATE TABLE IF NOT EXISTS reactions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    message_id UUID NOT NULL REFERENCES messages(id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    emoji VARCHAR(10) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,

    -- One emoji per user per message
    UNIQUE(message_id, user_id, emoji)
);

CREATE INDEX IF NOT EXISTS idx_reactions_message_id ON reactions(message_id);

-- ============================================================================
-- 7. ACTIONS TABLE (Analytics)
--    Features: JSONB column, ON DELETE SET NULL
-- ============================================================================

CREATE TABLE IF NOT EXISTS actions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    -- User can be null (anonymous actions or deleted user)
    user_id UUID REFERENCES users(id) ON DELETE SET NULL,

    action_type VARCHAR(100) NOT NULL,

    -- Flexible metadata storage with JSONB
    metadata JSONB,

    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- Composite index for analytics queries
CREATE INDEX IF NOT EXISTS idx_actions_user_id_created_at ON actions(user_id, created_at);
CREATE INDEX IF NOT EXISTS idx_actions_action_type ON actions(action_type);

-- ============================================================================
-- 8. AUTH CODES TABLE (OAuth flow)
--    Features: Simple foreign key with cascade
-- ============================================================================

CREATE TABLE IF NOT EXISTS auth_codes (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    code_hash VARCHAR(255) NOT NULL UNIQUE,
    expires_at TIMESTAMP WITH TIME ZONE NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    used_at TIMESTAMP WITH TIME ZONE
);

CREATE INDEX IF NOT EXISTS idx_auth_codes_hash ON auth_codes(code_hash);
CREATE INDEX IF NOT EXISTS idx_auth_codes_expires_at ON auth_codes(expires_at);

-- ============================================================================
-- 9. OAUTH STATES TABLE (CSRF protection)
-- ============================================================================

CREATE TABLE IF NOT EXISTS oauth_states (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    state_hash VARCHAR(255) NOT NULL UNIQUE,
    nonce VARCHAR(255) NOT NULL,
    provider VARCHAR(50) NOT NULL,
    expires_at TIMESTAMP WITH TIME ZONE NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_oauth_states_hash ON oauth_states(state_hash);
CREATE INDEX IF NOT EXISTS idx_oauth_states_expires_at ON oauth_states(expires_at);

-- ============================================================================
-- 10. TRIGGERS
--     Features: BEFORE/AFTER triggers, DROP TRIGGER IF EXISTS
-- ============================================================================

-- Drop existing triggers (idempotent)
DROP TRIGGER IF EXISTS update_users_updated_at ON users;
DROP TRIGGER IF EXISTS update_conversations_updated_at ON conversations;

-- Create BEFORE UPDATE trigger for users.updated_at
CREATE TRIGGER update_users_updated_at
    BEFORE UPDATE ON users
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Create BEFORE UPDATE trigger for conversations.updated_at
CREATE TRIGGER update_conversations_updated_at
    BEFORE UPDATE ON conversations
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Create AFTER INSERT trigger for audit logging
CREATE TRIGGER audit_user_creation
    AFTER INSERT ON users
    FOR EACH ROW EXECUTE FUNCTION log_user_creation();

-- ============================================================================
-- 11. SAMPLE DATA INSERTION
--     Features: UUID literal values, string to UUID coercion
-- ============================================================================

-- Insert a test user with explicit UUID
INSERT INTO users (id, email, name, provider, password_hash)
VALUES (
    '550e8400-e29b-41d4-a716-446655440000',
    'test@example.com',
    'Test User',
    'email',
    '$2b$12$hashed_password_here'
);

-- Insert another user (UUID auto-generated)
INSERT INTO users (email, name, provider, provider_user_id)
VALUES (
    'oauth@example.com',
    'OAuth User',
    'google',
    'google-user-id-123'
);

-- Insert a conversation
INSERT INTO conversations (user_id, title)
VALUES ('550e8400-e29b-41d4-a716-446655440000', 'First Conversation');

-- Insert messages with role validation
INSERT INTO messages (conversation_id, role, content)
SELECT c.id, 'user', 'Hello, how are you?'
FROM conversations c
WHERE c.title = 'First Conversation';

INSERT INTO messages (conversation_id, role, content)
SELECT c.id, 'assistant', 'I am doing well, thank you for asking!'
FROM conversations c
WHERE c.title = 'First Conversation';

-- Insert an action with JSONB metadata
INSERT INTO actions (user_id, action_type, metadata)
VALUES (
    '550e8400-e29b-41d4-a716-446655440000',
    'page_view',
    '{"page": "/dashboard", "referrer": "https://google.com", "duration_ms": 5000}'
);

-- ============================================================================
-- 12. QUERYING THE DATA
-- ============================================================================

-- Get all users with their conversation count
SELECT
    u.id,
    u.email,
    u.name,
    u.provider,
    u.created_at
FROM users u;

-- Get messages in a conversation
SELECT
    m.role,
    m.content,
    m.created_at
FROM messages m
JOIN conversations c ON m.conversation_id = c.id
WHERE c.title = 'First Conversation'
ORDER BY m.created_at;

-- Get recent actions with metadata
SELECT
    a.action_type,
    a.metadata,
    a.created_at,
    u.email as user_email
FROM actions a
LEFT JOIN users u ON a.user_id = u.id
ORDER BY a.created_at DESC;