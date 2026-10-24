#!/usr/bin/env bash
set -euo pipefail

URL="${1:-http://localhost:8080}"

if ! command -v curl >/dev/null 2>&1; then
    echo "ERROR: curl is not installed." >&2
    exit 1
fi

HTTP_STATUS=$(curl --silent --output /dev/null \
    --write-out '%{http_code}' \
    --max-time 5 "$URL") || {
        echo "FAIL: Could not connect to $URL" >&2
        exit 1
    }

if [[ "$HTTP_STATUS" == "200" ]]; then
    echo "PASS: $URL returned HTTP $HTTP_STATUS"
else
    echo "FAIL: $URL returned HTTP $HTTP_STATUS; expected 200" >&2
    exit 1
fi
