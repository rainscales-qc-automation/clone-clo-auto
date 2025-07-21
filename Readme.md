<!-- robot -d results d:\Training_Auto\project_clo\test\login_tests.robot -->
<!-- Original command: robot -d results d:\Training_Auto\project_clo\test\login_tests.robot -->


# Robot Framework CLO Project

This project contains Robot Framework test automation for CLO (Course Learning Outcomes) system with automated email notification.

## Project Structure

- `libs/` - Custom Python libraries and keywords
- `pages/` - Page Object Model implementation
- `resources/` - Robot Framework resource files
- `test/` - Test cases
- `results/` - Test execution results
- `email_service/` - Email notification service
- `robot_test_runner.py` - Main test runner with email integration
- `run_tests.py` - Simple script to run tests and send email

## Setup

1. Install dependencies:


```bash
pip install -r requirements.txt
```

2. Configure email settings:
```bash
# Edit email_service/config.json with your email credentials
{
  "host": "smtp.gmail.com",
  "mail": "your-email@gmail.com",
  "password": "your-app-password",
  "port": 587,
  "mail_goal": ["recipient@gmail.com"]
}
```

## Running Tests

### Option 1: Run tests with email notification (Recommended)
```bash
python run_tests.py
```

### Option 2: Use shell scripts
```bash
# Linux/Mac
chmod +x run_tests.sh
./run_tests.sh

# Windows
run_tests.bat
```

### Option 3: Manual Robot Framework execution
```bash
robot --outputdir results test/
```

## Features

- ✅ Automated execution of all Robot Framework tests
- ✅ Result parsing and summary generation
- ✅ Email notification with test results
- ✅ HTML/XML report attachments
- ✅ Error handling and logging
- ✅ Cross-platform support

## Test Results

Test results are generated in the `results/` directory:
- `report.html` - Test execution report
- `log.html` - Detailed test log
- `output.xml` - XML output for further processing

Results are automatically sent via email after test execution completes.

