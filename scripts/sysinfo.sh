#!/usr/bin/env bash
set -euo pipefail

echo "===== System Information ====="
echo "Current user: $(whoami)"
echo "Effective UID: $EUID"
echo "Hostname: $(hostname)"
echo "Kernel release: $(uname -r)"
echo "Current date: $(date --iso-8601=seconds)"

echo
echo "===== Disk Usage ====="
df -h /

echo
echo "===== Memory Usage ====="
if command -v free >/dev/null 2>&1; then
    free -h
else
    echo "Memory information unavailable: 'free' command not installed."
fi

echo
echo "===== Docker Status ====="
if docker info >/dev/null 2>&1; then
    echo "Docker daemon: running"
else
    echo "Docker daemon: unavailable"
fi
