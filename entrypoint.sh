#!/usr/bin/env bash

echo "Running \"$1\""

case "$1" in
build-db)
  until pg_isready -h postgres -d sales -U admin; do
    echo "Waiting for database to startup..."
    sleep 1
  done
  psql -h postgres -d sales -U admin -f ../sql/setup.sql

  num_rows=$(psql -h postgres -d sales -U admin -t -A -X -q -c "select count(1) from dwh.people;")

  if [ "$num_rows" -gt 0 ]; then
    echo "Database already populated."
  else
    psql -h postgres -d sales -U admin -c "\copy dwh.orders FROM '../data/orders.csv' DELIMITER ',' CSV"
    psql -h postgres -d sales -U admin -c "\copy dwh.people FROM '../data/people.csv' DELIMITER ',' CSV"
    psql -h postgres -d sales -U admin -c "\copy dwh.returns FROM '../data/returns.csv' DELIMITER ',' CSV"
      fi
  ;;
*)
  echo "Unknown command: $1"
  exit 1
  ;;
esac