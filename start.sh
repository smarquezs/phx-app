#!/bin/bash

# Wait until Postgres is ready
while ! pg_isready -q --host=database
do
  echo "$(date) - waiting for database to start"
  sleep 2
done

# Create, database, if it doesn't exist.
if [[ -z `psql -Atqc "\\list $PGDATABASE"` ]]; then
  mix ecto.create
fi

# Run migrations
mix ecto.migrate

# Start server
exec mix phx.server