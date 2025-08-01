#!/bin/bash

# Build script for Robot Framework Docker image
# Usage: ./build.sh [tag]

set -e

# Default values
DEFAULT_TAG="latest"
IMAGE_NAME="robot-framework-tests"

# Get tag from argument or use default
TAG=${1:-$DEFAULT_TAG}

echo "🚀 Building Robot Framework Docker image..."
echo "Image: ${IMAGE_NAME}:${TAG}"
echo "Context: $(pwd)/.."
echo "Dockerfile: $(pwd)/Dockerfile"

# Check if Dockerfile exists
if [ ! -f "Dockerfile" ]; then
    echo "❌ Error: Dockerfile not found in current directory"
    echo "Please run this script from the deploy directory"
    exit 1
fi

# Build the image
echo "📦 Building Docker image..."
docker build -f Dockerfile -t ${IMAGE_NAME}:${TAG} ..

# Tag as latest if not already latest
if [ "$TAG" != "latest" ]; then
    docker tag ${IMAGE_NAME}:${TAG} ${IMAGE_NAME}:latest
    echo "🏷️  Tagged as ${IMAGE_NAME}:latest"
fi

echo "✅ Build completed successfully!"
echo "📋 Image details:"
docker images | grep ${IMAGE_NAME}

echo ""
echo "🎯 Next steps:"
echo "  • Run tests: ./run-tests.sh"
echo "  • Start development environment: ./dev.sh"
echo "  • View results: ./view-results.sh"
