#!/bin/bash
set -euo pipefail

run_stack() {
    docker compose up -d 2>&1 || true
}

# consider that any missing path can be reported first
# we are getting non-deterministic results when running docker compose up
# see: https://github.com/docker/compose/issues/13712
missing_paths() {
    run_result="$(run_stack)"
    # echo "$run_result"

    if printf '%s\n' "$run_result" | grep --quiet "bind source path does not exist:.*traefik.yaml"; then
        echo "creating traefik.yaml"
        mv traefik.sample.yaml traefik.yaml
    fi

    if printf '%s\n' "$run_result" | grep --quiet "bind source path does not exist:.*/volumes/acme"; then
        echo "creating ACME directory"
        mkdir -p volumes/acme
    fi

    if printf '%s\n' "$run_result" | grep --quiet "bind source path does not exist:.*/volumes/logs"; then
        echo "creating logs directory"
        mkdir -p volumes/logs
    fi
}

missing_paths
missing_paths
missing_paths
