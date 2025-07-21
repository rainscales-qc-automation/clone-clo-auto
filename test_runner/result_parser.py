"""
Result parser module for Robot Framework test results
"""
import xml.etree.ElementTree as ET
import os
from datetime import datetime


class ResultParser:
    def __init__(self, output_file_path):
        self.output_file_path = output_file_path
    
    def parse_results(self):
        """Parse Robot Framework output.xml file and extract test results"""
        if not os.path.exists(self.output_file_path):
            return {
                'total': 0,
                'passed': 0,
                'failed': 0,
                'success_rate': 0,
                'overall_status': 'UNKNOWN',
                'duration': 'N/A',
                'start_time': 'N/A',
                'end_time': 'N/A'
            }
        
        try:
            tree = ET.parse(self.output_file_path)
            root = tree.getroot()
            
            # Get statistics
            statistics = root.find('.//statistics')
            total_stats = statistics.find('.//stat[@pass]') if statistics is not None else None
            
            if total_stats is not None:
                passed = int(total_stats.get('pass', 0))
                failed = int(total_stats.get('fail', 0))
                total = passed + failed
                success_rate = (passed / total * 100) if total > 0 else 0
                overall_status = 'PASS' if failed == 0 and total > 0 else 'FAIL'
            else:
                # Fallback: count test cases manually
                test_cases = root.findall('.//test')
                passed = len([tc for tc in test_cases if tc.find('status').get('status') == 'PASS'])
                failed = len([tc for tc in test_cases if tc.find('status').get('status') == 'FAIL'])
                total = len(test_cases)
                success_rate = (passed / total * 100) if total > 0 else 0
                overall_status = 'PASS' if failed == 0 and total > 0 else 'FAIL'
            
            # Get timing information
            suite = root.find('suite')
            if suite is not None:
                status = suite.find('status')
                if status is not None:
                    start_time = status.get('starttime', 'N/A')
                    end_time = status.get('endtime', 'N/A')
                    
                    # Calculate duration
                    if start_time != 'N/A' and end_time != 'N/A':
                        try:
                            start_dt = datetime.strptime(start_time, '%Y%m%d %H:%M:%S.%f')
                            end_dt = datetime.strptime(end_time, '%Y%m%d %H:%M:%S.%f')
                            duration = str(end_dt - start_dt)
                        except:
                            duration = 'N/A'
                    else:
                        duration = 'N/A'
                else:
                    start_time = end_time = duration = 'N/A'
            else:
                start_time = end_time = duration = 'N/A'
            
            return {
                'total': total,
                'passed': passed,
                'failed': failed,
                'success_rate': success_rate,
                'overall_status': overall_status,
                'duration': duration,
                'start_time': start_time,
                'end_time': end_time
            }
            
        except Exception as e:
            print(f"Error parsing results: {str(e)}")
            return {
                'total': 0,
                'passed': 0,
                'failed': 0,
                'success_rate': 0,
                'overall_status': 'ERROR',
                'duration': 'N/A',
                'start_time': 'N/A',
                'end_time': 'N/A',
                'error': str(e)
            }
    
    def get_failed_tests(self):
        """Get list of failed test cases"""
        if not os.path.exists(self.output_file_path):
            return []
        
        try:
            tree = ET.parse(self.output_file_path)
            root = tree.getroot()
            
            failed_tests = []
            test_cases = root.findall('.//test')
            
            for test_case in test_cases:
                status = test_case.find('status')
                if status is not None and status.get('status') == 'FAIL':
                    test_name = test_case.get('name', 'Unknown')
                    error_msg = status.text if status.text else 'No error message'
                    failed_tests.append({
                        'name': test_name,
                        'error': error_msg
                    })
            
            return failed_tests
            
        except Exception as e:
            print(f"Error getting failed tests: {str(e)}")
            return []
