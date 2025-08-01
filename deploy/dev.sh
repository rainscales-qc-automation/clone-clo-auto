#!/bin/bash

# Development environment script for Robot Framework
# Usage: ./dev.sh [command]

set -e

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
    echo "Usage: $0 [COMMAND]"
    echo ""
    echo "Commands:"
    echo "  start       Start development environment"
    echo "  stop        Stop development environment"
    echo "  restart     Restart development environment"
    echo "  shell       Open shell in development container"
    echo "  logs        Show container logs"
    echo "  test        Run tests in development environment"
    echo "  build       Build development image"
    echo "  clean       Clean up development environment"
    echo "  status      Show status of development environment"
    echo ""
    echo "Examples:"
    echo "  $0 start     # Start development environment"
    echo "  $0 shell     # Open shell in container"
    echo "  $0 test      # Run tests"
}

# Function to check if development environment is running
is_running() {
    docker-compose -f docker-compose.dev.yml ps -q robot-tests-dev | grep -q .
}

# Function to start development environment
start_dev() {
    print_status "Starting development environment..."
    docker-compose -f docker-compose.dev.yml up -d
    print_success "Development environment started!"
    print_status "Results viewer available at: http://localhost:8080"
    print_status "Use './dev.sh shell' to access the container"
}

# Function to stop development environment
stop_dev() {
    print_status "Stopping development environment..."
    docker-compose -f docker-compose.dev.yml down
    print_success "Development environment stopped!"
}

# Function to restart development environment
restart_dev() {
    print_status "Restarting development environment..."
    docker-compose -f docker-compose.dev.yml restart
    print_success "Development environment restarted!"
}

# Function to open shell in container
open_shell() {
    if ! is_running; then
        print_warning "Development environment is not running. Starting it first..."
        start_dev
        sleep 3
    fi
    
    print_status "Opening shell in development container..."
    docker-compose -f docker-compose.dev.yml exec robot-tests-dev bash
}

# Function to show logs
show_logs() {
    print_status "Showing development container logs..."
    docker-compose -f docker-compose.dev.yml logs -f robot-tests-dev
}

# Function to run tests in development environment
run_tests_dev() {
    if ! is_running; then
        print_warning "Development environment is not running. Starting it first..."
        start_dev
        sleep 3
    fi
    
    print_status "Running tests in development environment..."
    docker-compose -f docker-compose.dev.yml exec robot-tests-dev python run_tests.py
}

# Function to build development image
build_dev() {
    print_status "Building development image..."
    docker-compose -f docker-compose.dev.yml build
    print_success "Development image built successfully!"
}

# Function to clean up development environment
clean_dev() {
    print_status "Cleaning up development environment..."
    docker-compose -f docker-compose.dev.yml down -v --rmi local
    print_success "Development environment cleaned up!"
}

# Function to show status
show_status() {
    print_status "Development environment status:"
    docker-compose -f docker-compose.dev.yml ps
}

# Parse command
case ${1:-start} in
    start)
        start_dev
        ;;
    stop)
        stop_dev
        ;;
    restart)
        restart_dev
        ;;
    shell)
        open_shell
        ;;
    logs)
        show_logs
        ;;
    test)
        run_tests_dev
        ;;
    build)
        build_dev
        ;;
    clean)
        clean_dev
        ;;
    status)
        show_status
        ;;
    help|--help|-h)
        show_help
        ;;
    *)
        print_error "Unknown command: $1"
        show_help
        exit 1
        ;;
esac
