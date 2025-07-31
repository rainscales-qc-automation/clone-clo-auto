#!/bin/bash

# Jenkins Setup Script for Robot Framework Project
# This script helps setup the Jenkins environment for running Robot Framework tests

set -e  # Exit on any error

echo "=========================================="
echo "Jenkins Setup for Robot Framework Tests"
echo "=========================================="

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if Python 3.10 is installed
echo "Checking Python 3.10 installation..."
if command_exists python3.10; then
    echo "✓ Python 3.10 found: $(python3.10 --version)"
else
    echo "✗ Python 3.10 not found!"
    echo "Please install Python 3.10 first:"
    echo "  Ubuntu/Debian: sudo apt update && sudo apt install python3.10 python3.10-venv python3.10-dev"
    echo "  CentOS/RHEL: sudo yum install python310 python310-devel"
    echo "  Or download from: https://www.python.org/downloads/"
    exit 1
fi

# Check if pip is available
echo "Checking pip installation..."
if python3.10 -m pip --version >/dev/null 2>&1; then
    echo "✓ pip is available"
else
    echo "✗ pip not found for Python 3.10"
    echo "Installing pip..."
    python3.10 -m ensurepip --upgrade
fi

# Check if git is installed
echo "Checking Git installation..."
if command_exists git; then
    echo "✓ Git found: $(git --version)"
else
    echo "✗ Git not found! Please install Git first."
    exit 1
fi

# Create test virtual environment to verify setup
echo "Testing virtual environment creation..."
TEST_VENV="test_robot_env"

if [ -d "$TEST_VENV" ]; then
    rm -rf "$TEST_VENV"
fi

python3.10 -m venv "$TEST_VENV"
source "$TEST_VENV/bin/activate"

echo "Installing requirements in test environment..."
pip install --upgrade pip
pip install -r requirements.txt

echo "Verifying Robot Framework installation..."
robot --version

echo "Cleaning up test environment..."
deactivate
rm -rf "$TEST_VENV"

echo ""
echo "=========================================="
echo "✓ Setup verification completed successfully!"
echo "=========================================="
echo ""
echo "Next steps:"
echo "1. Make sure Jenkins has access to Python 3.10"
echo "2. Configure Jenkins job to use this repository"
echo "3. Set up webhook in GitHub/GitLab for automatic triggering"
echo ""
echo "Jenkins Pipeline Configuration:"
echo "- Use 'Pipeline script from SCM'"
echo "- Point to your repository"
echo "- Script Path: Jenkinsfile"
echo ""
echo "For webhook setup:"
echo "- GitHub: Settings > Webhooks > Add webhook"
echo "- Payload URL: http://your-jenkins-url/github-webhook/"
echo "- Content type: application/json"
echo "- Events: Just the push event"
echo ""
