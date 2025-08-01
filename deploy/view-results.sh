#!/bin/bash

# Script to view Robot Framework test results
# Usage: ./view-results.sh [options]

set -e

# Default values
RESULTS_DIR="$(pwd)/results"
PORT="8080"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

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
    echo "  -r, --results DIR    Results directory (default: ./results)"
    echo "  -p, --port PORT      Port for web server (default: 8080)"
    echo "  -h, --help          Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0                   # View results from ./results on port 8080"
    echo "  $0 -p 9000          # Use port 9000"
    echo "  $0 -r /tmp/results  # View results from custom directory"
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -r|--results)
            RESULTS_DIR="$2"
            shift 2
            ;;
        -p|--port)
            PORT="$2"
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

# Check if results directory exists
if [ ! -d "${RESULTS_DIR}" ]; then
    print_error "Results directory not found: ${RESULTS_DIR}"
    print_status "Run tests first with: ./run-tests.sh"
    exit 1
fi

# Check if there are any results
if [ ! "$(ls -A ${RESULTS_DIR})" ]; then
    print_warning "Results directory is empty: ${RESULTS_DIR}"
    print_status "Run tests first with: ./run-tests.sh"
    exit 1
fi

print_status "Starting results viewer..."
print_status "Results directory: ${RESULTS_DIR}"
print_status "Port: ${PORT}"

# Check if port is already in use
if lsof -Pi :${PORT} -sTCP:LISTEN -t >/dev/null 2>&1; then
    print_warning "Port ${PORT} is already in use!"
    print_status "Trying to stop existing results viewer..."
    docker-compose -f docker-compose.yml --profile viewer down 2>/dev/null || true
    sleep 2
fi

# Start the results viewer
print_status "Starting nginx container to serve results..."
docker run -d \
    --name robot-results-viewer-$(date +%s) \
    --rm \
    -p ${PORT}:80 \
    -v "${RESULTS_DIR}:/usr/share/nginx/html:ro" \
    -v "$(pwd)/nginx.conf:/etc/nginx/conf.d/default.conf:ro" \
    nginx:alpine

# Wait a moment for the container to start
sleep 3

# Check if container is running
if docker ps --format "{{.Names}}" | grep -q "robot-results-viewer"; then
    print_success "Results viewer started successfully!"
    print_status "🌐 Open your browser and go to: http://localhost:${PORT}"
    print_status ""
    print_status "Available files:"
    ls -la "${RESULTS_DIR}"
    print_status ""
    print_status "📊 Direct links:"
    [ -f "${RESULTS_DIR}/report.html" ] && print_status "  • Report: http://localhost:${PORT}/report.html"
    [ -f "${RESULTS_DIR}/log.html" ] && print_status "  • Log: http://localhost:${PORT}/log.html"
    [ -f "${RESULTS_DIR}/output.xml" ] && print_status "  • Output: http://localhost:${PORT}/output.xml"
    print_status ""
    print_status "To stop the viewer, press Ctrl+C or run:"
    print_status "docker stop \$(docker ps -q --filter ancestor=nginx:alpine)"
else
    print_error "Failed to start results viewer!"
    exit 1
fi
