#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd -- "${SCRIPT_DIR}/../.." && pwd)"

cd "${REPO_ROOT}"

echo "[postCreate] Workspace: ${REPO_ROOT}"

echo "[postCreate] Checking for corporate TLS interception..."
sudo -E sh "${SCRIPT_DIR}/install-corp-ca.sh"

echo "[postCreate] Creating Python virtual environment..."

python3 -m venv .venv

source .venv/bin/activate

pip install --upgrade pip

echo "[postCreate] Installing LangGraph dependencies..."

pip install \
  langgraph \
  langchain \
  langchain-openai \
  langsmith \
  python-dotenv \
  ipykernel \
  jupyter

echo "[postCreate] Done."

echo ""
echo "┌──────────────────────────────────────────────────────────┐"
echo "│ LangGraph Workspace Ready                               │"
echo "│                                                        │"
echo "│ Activate: source .venv/bin/activate                    │"
echo "│ Login to Devin manually when needed:                   │"
echo "│                                                        │"
echo "│    devin setup                                         │"
echo "└──────────────────────────────────────────────────────────┘"