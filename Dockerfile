# Dockerfile
# Postgres with pgvector enabled

FROM pgvector/pgvector:pg17

# Default DB config (can still be overridden by env vars in Railway)
ENV POSTGRES_DB=vectordb
ENV POSTGRES_USER=vectordb
ENV POSTGRES_PASSWORD=vectordb

# Use subdirectory under the mount point for PGDATA
ENV PGDATA=/var/lib/postgresql/data/pgdata

# Copy init script so Postgres runs it on first startup
COPY init-db.sql /docker-entrypoint-initdb.d/

# Expose Postgres default port
EXPOSE 5432

# Use the default Postgres entrypoint + CMD from the base image
