#!/bin/bash
set -euo pipefail

uv run --prerelease=allow --with copier --with copier-templates-extensions --with copier-template-tester==2.4.0b0 ctt
