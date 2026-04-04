#!/bin/bash
set -euo pipefail

rm -rf .ctt/*
uv run ctt
