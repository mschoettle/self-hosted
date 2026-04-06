#!/bin/bash
set -euo pipefail

validate_config() {
    docker compose config --quiet 2>&1 || true
}

# consider that any missing variable can be reported first
# we are getting non-deterministic results when running docker compose config --quiet
# see: https://github.com/docker/compose/issues/13712
check_config() {
    validate_result="$(validate_config)"
    # echo $validate_result
    if printf '%s\n' "$validate_result" | grep --quiet "required variable TIMEZONE is missing a value"; then
        echo "setting timezone"
        sed -i.bak "s|^TIMEZONE=$|TIMEZONE=America/Toronto|" .env
        # cat .env
    fi

    if printf '%s\n' "$validate_result" | grep --quiet "required variable TRAEFIK_ACME_PATH is missing a value"; then
        echo "setting acme path"
        sed -i.bak "s|^TRAEFIK_ACME_PATH=$|TRAEFIK_ACME_PATH=./volumes/acme|" .env
    fi

    if printf '%s\n' "$validate_result" | grep --quiet "required variable TRAEFIK_LOGS_PATH is missing a value"; then
        echo "setting logs path"
        sed -i.bak "s|^TRAEFIK_LOGS_PATH=$|TRAEFIK_LOGS_PATH=./volumes/logs|" .env
    fi
}

# Check that all variables are required
docker compose config --variables --format json | jq --exit-status '[.[] | .Required] | all'

check_config
check_config
check_config

docker compose config --quiet
