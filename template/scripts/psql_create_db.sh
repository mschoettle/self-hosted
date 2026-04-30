#!/bin/bash
set -euo pipefail

usage() {
  cat <<EOF
Usage: $(basename "$0") [OPTIONS]

Create a PostgreSQL database and user.

Options:
  -h, --help              Show this help
  -u, --user USER         Database user to create
  -p, --password PASSWORD Password for the user
  -d, --database DATABASE Database name to create
EOF
}

db_user=""
db_password=""
db_name=""

while [[ $# -gt 0 ]]; do
  case $1 in
    -h|--help) usage; exit 0 ;;
    -u|--user) db_user="$2"; shift 2 ;;
    -p|--password) db_password="$2"; shift 2 ;;
    -d|--database) db_name="$2"; shift 2 ;;
    --) shift; break ;;
    -*) echo "Error: unknown option $1" >&2; usage; exit 1 ;;
    *) echo "Error: unexpected argument $1" >&2; usage; exit 1 ;;
  esac
done

if [[ -z "$db_user" || -z "$db_password" || -z "$db_name" ]]; then
  echo "Error: --user, --password, and --database are required" >&2
  usage
  exit 1
fi

# requires additional grant on public schema: https://stackoverflow.com/a/75876944

docker compose exec --no-TTY db psql -v ON_ERROR_STOP=1 --username postgres <<-EOSQL
	CREATE USER ${db_user} WITH ENCRYPTED PASSWORD '${db_password}';
	CREATE DATABASE ${db_name};
	GRANT ALL PRIVILEGES ON DATABASE ${db_name} TO ${db_user};
	\c ${db_name} postgres;
	GRANT ALL ON SCHEMA public TO ${db_user};
EOSQL
