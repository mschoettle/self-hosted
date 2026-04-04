#!/bin/bash
set -euo pipefail

run_stack() {
    docker compose up -d 2>&1 || true
}

# only one missing bind source path is shown at a time
# which missing bind source path is shown first is random
missing_paths() {
    printf '%s\n' "$(run_stack)" | grep --quiet "bind source path does not exist:" | grep -E --quiet "traefik\.yaml|/volumes/logs|/volumes/acme$"
}

missing_paths
mv traefik.sample.yaml traefik.yaml

missing_paths
mkdir -p volumes/acme

missing_paths
mkdir volumes/logs
