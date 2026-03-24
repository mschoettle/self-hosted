#!/bin/bash
set -euo pipefail

uv run --prerelease=allow --with copier --with copier-templates-extensions --with copier-template-tester ctt
