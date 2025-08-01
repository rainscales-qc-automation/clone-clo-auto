#!/bin/bash

# Test script to verify Jenkins pipeline components
set -e

echo "🔍 Testing Jenkins Pipeline Components..."

# Test 1: Docker image exists
echo "1. Testing Docker image exists..."
if docker images | grep -q robot-framework-tests; then
    echo "✅ Docker image found"
else
    echo "❌ Docker image not found"
    exit 1
fi

# Test 2: Python works
echo "2. Testing Python installation..."
if docker run --rm robot-framework-tests:latest python --version; then
    echo "✅ Python working"
else
    echo "❌ Python test failed"
    exit 1
fi

# Test 3: Robot Framework works
echo "3. Testing Robot Framework installation..."
ROBOT_OUTPUT=$(docker run --rm robot-framework-tests:latest robot --version 2>&1)
if echo "$ROBOT_OUTPUT" | grep -q "Robot Framework"; then
    echo "✅ Robot Framework working: $ROBOT_OUTPUT"
else
    echo "❌ Robot Framework test failed: $ROBOT_OUTPUT"
    exit 1
fi

# Test 4: Chrome works
echo "4. Testing Chrome installation..."
if docker run --rm robot-framework-tests:latest google-chrome --version; then
    echo "✅ Chrome working"
else
    echo "❌ Chrome test failed"
    exit 1
fi

# Test 5: ChromeDriver works
echo "5. Testing ChromeDriver installation..."
if docker run --rm robot-framework-tests:latest chromedriver --version; then
    echo "✅ ChromeDriver working"
else
    echo "❌ ChromeDriver test failed"
    exit 1
fi

# Test 6: WebDriver functionality
echo "6. Testing Chrome WebDriver functionality..."
if timeout 60 docker run --rm robot-framework-tests:latest python3 /app/deploy/test_chrome.py; then
    echo "✅ Chrome WebDriver working"
else
    echo "❌ Chrome WebDriver test failed"
    exit 1
fi

# Test 7: Simple Robot test
echo "7. Testing simple Robot Framework test..."
mkdir -p results
if timeout 120 docker run --rm -v $(pwd)/results:/app/results robot-framework-tests:latest robot --outputdir /app/results /app/deploy/simple_test.robot; then
    echo "✅ Simple Robot test working"
else
    echo "❌ Simple Robot test failed"
    exit 1
fi

echo "🎉 All Jenkins pipeline components working correctly!"
echo "📊 Test Results:"
ls -la results/ || echo "No results directory"

exit 0
