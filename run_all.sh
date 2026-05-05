#!/usr/bin/env bash
# run_all.sh — Re-execute the full analysis workflow
# Usage: bash run_all.sh

set -e

echo "[1/2] Verifying SHA-256 checksums of input data..."
( cd Datasets && sha256sum -c ../checksums.txt )

echo "[2/2] Executing analysis notebook..."
jupyter nbconvert --to notebook --execute Final_Script.ipynb \
    --output Final_Script_executed.ipynb

echo "Done. See Final_Script_executed.ipynb for results."
