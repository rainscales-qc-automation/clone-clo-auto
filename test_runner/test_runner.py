"""
Main test runner module for Robot Framework tests
"""
import os
import subprocess
import sys
from datetime import datetime
from .config import TEST_CONFIG
from .result_parser import ResultParser
from .email_sender import EmailSender


class RobotTestRunner:
    def __init__(self, project_root=None):
        self.project_root = project_root or os.getcwd()
        self.test_config = TEST_CONFIG
        self.email_sender = EmailSender()
        
        # Set up paths
        self.test_dir = os.path.join(self.project_root, self.test_config['test_directory'])
        self.results_dir = os.path.join(self.project_root, self.test_config['results_directory'])
        
        # Ensure results directory exists
        os.makedirs(self.results_dir, exist_ok=True)
    
    def run_tests(self):
        """Run all Robot Framework tests in the test directory"""
        print(f"Starting Robot Framework test execution at {datetime.now()}")
        print(f"Test directory: {self.test_dir}")
        print(f"Results directory: {self.results_dir}")
        
        # Build robot command
        output_file = os.path.join(self.results_dir, self.test_config['output_file'])
        log_file = os.path.join(self.results_dir, self.test_config['log_file'])
        report_file = os.path.join(self.results_dir, self.test_config['report_file'])
        
        robot_cmd = [
            'robot',
            '--outputdir', self.results_dir,
            '--output', output_file,
            '--log', log_file,
            '--report', report_file,
            '--loglevel', 'INFO',
            self.test_dir
        ]
        
        print(f"Executing command: {' '.join(robot_cmd)}")
        
        try:
            # Run robot tests
            result = subprocess.run(
                robot_cmd,
                cwd=self.project_root,
                capture_output=True,
                text=True,
                timeout=3600  # 1 hour timeout
            )
            
            print(f"Robot Framework execution completed with return code: {result.returncode}")
            
            if result.stdout:
                print("STDOUT:")
                print(result.stdout)
            
            if result.stderr:
                print("STDERR:")
                print(result.stderr)
            
            return result.returncode == 0, output_file, log_file, report_file
            
        except subprocess.TimeoutExpired:
            print("Test execution timed out after 1 hour")
            return False, None, None, None
        except Exception as e:
            print(f"Error running tests: {str(e)}")
            return False, None, None, None
    
    def collect_results(self, output_file):
        """Collect and parse test results"""
        print("Collecting test results...")
        
        if not output_file or not os.path.exists(output_file):
            print("Output file not found, cannot parse results")
            return None
        
        parser = ResultParser(output_file)
        results = parser.parse_results()
        failed_tests = parser.get_failed_tests()
        
        results['failed_tests'] = failed_tests
        
        print(f"Test Results Summary:")
        print(f"  Total: {results['total']}")
        print(f"  Passed: {results['passed']}")
        print(f"  Failed: {results['failed']}")
        print(f"  Success Rate: {results['success_rate']:.2f}%")
        print(f"  Overall Status: {results['overall_status']}")
        print(f"  Duration: {results['duration']}")
        
        if failed_tests:
            print(f"\nFailed Tests:")
            for test in failed_tests:
                print(f"  - {test['name']}: {test['error']}")
        
        return results
    
    def send_results_email(self, results, attachments=None):
        """Send test results via email"""
        print("Sending test results email...")
        
        if results is None:
            print("No results to send")
            return False
        
        return self.email_sender.send_email(results, attachments)
    
    def run_full_test_cycle(self):
        """Run complete test cycle: execute tests, collect results, send email"""
        print("=" * 60)
        print("STARTING ROBOT FRAMEWORK TEST EXECUTION CYCLE")
        print("=" * 60)
        
        # Step 1: Run tests
        success, output_file, log_file, report_file = self.run_tests()
        
        # Step 2: Collect results
        results = self.collect_results(output_file)
        
        # Step 3: Prepare attachments
        attachments = []
        for file_path in [output_file, log_file, report_file]:
            if file_path and os.path.exists(file_path):
                attachments.append(file_path)
        
        # Step 4: Send email
        email_sent = self.send_results_email(results, attachments)
        
        print("=" * 60)
        print("TEST EXECUTION CYCLE COMPLETED")
        print(f"Tests executed: {'Successfully' if success else 'With errors'}")
        print(f"Email sent: {'Yes' if email_sent else 'No'}")
        print("=" * 60)
        
        return success, results, email_sent


def main():
    """Main entry point"""
    # Get project root (parent directory of test_runner)
    current_dir = os.path.dirname(os.path.abspath(__file__))
    project_root = os.path.dirname(current_dir)
    
    # Create and run test runner
    runner = RobotTestRunner(project_root)
    success, results, email_sent = runner.run_full_test_cycle()
    
    # Exit with appropriate code
    sys.exit(0 if success else 1)


if __name__ == "__main__":
    main()
