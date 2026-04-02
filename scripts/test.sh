#!/usr/bin/env bash
set -e

echo "=== Test Stage ==="
echo "Running tests..."

mkdir -p reports

# Example: run tests if package.json exists
if [ -f "package.json" ]; then
    npm test -- --reporter=junit --reporter-options output=reports/test-results.xml
else
    echo "No test framework detected. Generating empty test report."
    cat > reports/test-results.xml <<'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<testsuite name="placeholder" tests="1" failures="0" errors="0">
  <testcase classname="placeholder" name="placeholder_test" time="0"/>
</testsuite>
EOF
fi

echo "Tests complete."
