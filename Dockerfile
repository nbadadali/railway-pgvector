# Dockerfile
# Postgres with pgvector enabled

FROM pgvector/pgvector:pg17

# Optional: set a default DB name (can be overridden by env vars in Railway)
ENV POSTGRES_DB=vectordb
ENV POSTGRES_USER=vectordb
ENV POSTGRES_PASSWORD=vectordb

# Copy init script so Postgres runs it on first startup
# This will create schema, extension, and tables when the DB is first initialized.
COPY init-db.sql /docker-entrypoint-initdb.d/

# Expose Postgres default port (Railway will map it via TCP proxy or internal network)
EXPOSE 5432

# Use the default Postgres entrypoint + CMD from the base image
