#!/bin/bash

# Script to run Robot Framework tests using Docker
# Usage: ./run-tests.sh [options]

set -e

# Default values
IMAGE_NAME="robot-framework-tests"
TAG="latest"
RESULTS_DIR="$(pwd)/results"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Help function
show_help() {
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  -t, --tag TAG        Docker image tag (default: latest)"
    echo "  -r, --results DIR    Results directory (default: ./results)"
    echo "  -h, --help          Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0                   # Run with default settings"
    echo "  $0 -t dev           # Run with dev tag"
    echo "  $0 -r /tmp/results  # Use custom results directory"
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -t|--tag)
            TAG="$2"
            shift 2
            ;;
        -r|--results)
            RESULTS_DIR="$2"
            shift 2
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        *)
            print_error "Unknown option: $1"
            show_help
            exit 1
            ;;
    esac
done

print_status "Starting Robot Framework test execution..."
print_status "Image: ${IMAGE_NAME}:${TAG}"
print_status "Results directory: ${RESULTS_DIR}"

# Create results directory if it doesn't exist
mkdir -p "${RESULTS_DIR}"

# Check if Docker image exists
if ! docker images --format "{{.Repository}}:{{.Tag}}" | grep -q "${IMAGE_NAME}:${TAG}"; then
    print_error "Docker image ${IMAGE_NAME}:${TAG} not found!"
    print_status "Building image first..."
    ./build.sh ${TAG}
fi

# Run the tests
print_status "Running Robot Framework tests..."
docker run --rm \
    --name robot-tests-$(date +%s) \
    -v "${RESULTS_DIR}:/app/results" \
    -e DISPLAY=:99 \
    ${IMAGE_NAME}:${TAG}

# Check results
if [ -f "${RESULTS_DIR}/output.xml" ]; then
    print_success "Tests completed successfully!"
    print_status "Results saved to: ${RESULTS_DIR}"
    
    # Show basic statistics if available
    if [ -f "${RESULTS_DIR}/report.html" ]; then
        print_status "Report available at: ${RESULTS_DIR}/report.html"
    fi
    
    if [ -f "${RESULTS_DIR}/log.html" ]; then
        print_status "Log available at: ${RESULTS_DIR}/log.html"
    fi
    
    print_status "To view results in browser, run: ./view-results.sh"
else
    print_error "Test execution failed - no results found!"
    exit 1
fi
