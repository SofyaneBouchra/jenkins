#!/usr/bin/env bash
set -e

echo "=== Build Stage ==="
echo "Compiling application..."

# Example: install dependencies if package.json exists
if [ -f "package.json" ]; then
    npm ci
    npm run build
fi

echo "Build complete."
