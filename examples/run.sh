#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
PYTHONPATH=src python -m gbt_know_map info
PYTHONPATH=src python -m gbt_know_map check --payload '{}'
PYTHONPATH=src python -m gbt_know_map run   --payload '{}'
