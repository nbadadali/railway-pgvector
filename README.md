# pgvector on Railway

This repo runs **Postgres + pgvector** as a Railway service using the official `pgvector/pgvector` image.

It is meant to be used as a dedicated **vector database** for things like embeddings and semantic search.

## 1. Deploy to Railway

1. Push this repo to GitHub (e.g. `yourname/pgvector-on-railway`).
2. In Railway:
   - Open your existing project (the one with n8n + memory-api).
   - Click **New → Service → Deploy from GitHub**.
   - Select this repo.
3. Wait for Railway to build and start the container.

This will spin up a Postgres server with the `vector` extension available.

On **first startup**, `init-db.sql` will run and create:

- `app` schema  
- `pgvector` extension  
- `app.documents` table with a `vector(384)` column and indexes.

## 2. Configure environment variables

Go to the new service in Railway → **Variables** and set at least:

- `POSTGRES_DB` – e.g. `vector_db`
- `POSTGRES_USER` – e.g. `vector_user`
- `POSTGRES_PASSWORD` – strong password

These are used by the Postgres image to create the initial database and superuser.

### 2.1 Create a DATABASE_URL for other services

Still in the same service (`pgvector`), add a variable:

- **Name:** `DATABASE_URL`  
- **Value:**

  ```text
  postgresql://${POSTGRES_USER}:${POSTGRES_PASSWORD}@${RAILWAY_PRIVATE_DOMAIN}:5432/${POSTGRES_DB}
