-- init-db.sql

-- Create schema for your app
CREATE SCHEMA IF NOT EXISTS app;

-- Enable pgvector extension
CREATE EXTENSION IF NOT EXISTS vector;

-- Main documents table for embeddings
CREATE TABLE IF NOT EXISTS app.documents (
    id         uuid PRIMARY KEY,
    user_id    text NOT NULL,
    content    text NOT NULL,
    metadata   jsonb,
    embedding  vector(384) NOT NULL,  -- must match your embedding model dimension
    created_at timestamptz DEFAULT now()
);

-- Index for per-user lookups
CREATE INDEX IF NOT EXISTS idx_documents_user_id
    ON app.documents (user_id);

-- Approximate nearest neighbour index for vector search
-- Using IVFFlat with L2 distance (adjust as needed).
CREATE INDEX IF NOT EXISTS idx_documents_embedding
    ON app.documents USING ivfflat (embedding vector_l2_ops)
    WITH (lists = 100);
