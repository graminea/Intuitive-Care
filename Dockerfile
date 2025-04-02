# Use the official PostgreSQL image
FROM postgres:latest

# Install PL/Python3 dependencies
RUN apt-get update && apt-get install -y \
    postgresql-plpython3-$PG_MAJOR \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Set the default database name
ENV POSTGRES_DB=intuitive_care_db

# Set the default user and password (you can override these later)
ENV POSTGRES_USER=admin
ENV POSTGRES_PASSWORD=password
