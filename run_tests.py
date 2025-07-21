#!/usr/bin/env python3
"""
Simple script to run Robot Framework tests and send email results
"""
import sys
import os

# Add the current directory to Python path
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from test_runner.test_runner import RobotTestRunner


def main():
    """Main function to run tests"""
    print("Robot Framework Test Runner")
    print("=" * 40)
    
    try:
        # Create test runner instance
        runner = RobotTestRunner()
        
        # Run full test cycle
        success, results, email_sent = runner.run_full_test_cycle()
        
        # Print final summary
        print("\n" + "=" * 40)
        print("FINAL SUMMARY")
        print("=" * 40)
        
        if results:
            print(f"Tests Run: {results['total']}")
            print(f"Passed: {results['passed']}")
            print(f"Failed: {results['failed']}")
            print(f"Success Rate: {results['success_rate']:.2f}%")
            print(f"Overall Status: {results['overall_status']}")
        else:
            print("No test results available")
        
        print(f"Email Sent: {'Yes' if email_sent else 'No'}")
        
        return 0 if success else 1
        
    except KeyboardInterrupt:
        print("\nTest execution interrupted by user")
        return 1
    except Exception as e:
        print(f"Error during test execution: {str(e)}")
        return 1


if __name__ == "__main__":
    exit_code = main()
    sys.exit(exit_code)
