#!/bin/bash
set -euo pipefail

validate_config() {
    docker compose config --quiet 2>&1 || true
}

if printf '%s\n' "$(validate_config)" | grep --quiet "required variable TIMEZONE is missing a value"; then
    sed -i "s|^TIMEZONE=$|TIMEZONE=America/Toronto|" .env
fi

if printf '%s\n' "$(validate_config)" | grep --quiet "required variable TRAEFIK_ACME_PATH is missing a value"; then
    sed -i "s|^TRAEFIK_ACME_PATH=$|TRAEFIK_ACME_PATH=./volumes/acme|" .env
fi

if printf '%s\n' "$(validate_config)" | grep --quiet "required variable TRAEFIK_LOGS_PATH is missing a value"; then
    sed -i "s|^TRAEFIK_LOGS_PATH=$|TRAEFIK_LOGS_PATH=./volumes/logs|" .env
fi

cat .env

docker compose config --quiet

docker compose config
