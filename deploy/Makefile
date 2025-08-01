# Makefile for Robot Framework CI/CD

.PHONY: help build test dev clean view-results setup

# Default target
help:
	@echo "Robot Framework CI/CD Commands:"
	@echo ""
	@echo "  make setup        - Setup permissions and prepare environment"
	@echo "  make build        - Build Docker image"
	@echo "  make test         - Run Robot Framework tests"
	@echo "  make dev          - Start development environment"
	@echo "  make dev-shell    - Open shell in development container"
	@echo "  make dev-stop     - Stop development environment"
	@echo "  make view-results - Start results viewer"
	@echo "  make clean        - Clean up Docker images and containers"
	@echo "  make clean-all    - Clean everything including results"
	@echo ""
	@echo "Examples:"
	@echo "  make setup && make build && make test"
	@echo "  make dev && make dev-shell"

# Setup permissions and environment
setup:
	@echo "🔧 Setting up environment..."
	chmod +x *.sh
	mkdir -p results
	@echo "✅ Setup completed!"

# Build Docker image
build: setup
	@echo "🚀 Building Docker image..."
	./build.sh

# Run tests
test: build
	@echo "🧪 Running Robot Framework tests..."
	./run-tests.sh

# Development environment
dev: build
	@echo "🛠️ Starting development environment..."
	./dev.sh start

dev-shell:
	@echo "🐚 Opening development shell..."
	./dev.sh shell

dev-stop:
	@echo "🛑 Stopping development environment..."
	./dev.sh stop

dev-test:
	@echo "🧪 Running tests in development environment..."
	./dev.sh test

# View results
view-results:
	@echo "👀 Starting results viewer..."
	./view-results.sh

# Clean up
clean:
	@echo "🧹 Cleaning up Docker resources..."
	docker-compose -f docker-compose.yml down --rmi local || true
	docker-compose -f docker-compose.dev.yml down --rmi local || true
	docker system prune -f
	@echo "✅ Cleanup completed!"

clean-all: clean
	@echo "🗑️ Removing all results..."
	rm -rf results/*
	@echo "✅ All cleaned up!"

# Quick start
quick-start: setup build test view-results

# CI/CD simulation
ci: setup build test
	@echo "✅ CI pipeline completed successfully!"
