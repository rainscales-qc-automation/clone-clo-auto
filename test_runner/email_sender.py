"""
Email sender module for test results
"""
import smtplib
import os
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.mime.base import MIMEBase
from email import encoders
from datetime import datetime
from .config import EMAIL_CONFIG


class EmailSender:
    def __init__(self):
        self.config = EMAIL_CONFIG
    
    def create_email_content(self, test_results):
        """Create HTML email content with test results"""
        html_content = f"""
        <html>
        <head>
            <style>
                body {{ font-family: Arial, sans-serif; }}
                .header {{ background-color: #f0f0f0; padding: 10px; }}
                .summary {{ margin: 20px 0; }}
                .passed {{ color: green; font-weight: bold; }}
                .failed {{ color: red; font-weight: bold; }}
                .table {{ border-collapse: collapse; width: 100%; }}
                .table th, .table td {{ border: 1px solid #ddd; padding: 8px; text-align: left; }}
                .table th {{ background-color: #f2f2f2; }}
            </style>
        </head>
        <body>
            <div class="header">
                <h2>Robot Framework Test Results</h2>
                <p>Test execution completed at: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}</p>
            </div>
            
            <div class="summary">
                <h3>Test Summary</h3>
                <p><span class="passed">Passed: {test_results.get('passed', 0)}</span></p>
                <p><span class="failed">Failed: {test_results.get('failed', 0)}</span></p>
                <p>Total: {test_results.get('total', 0)}</p>
                <p>Success Rate: {test_results.get('success_rate', 0):.2f}%</p>
            </div>
            
            <div>
                <h3>Test Details</h3>
                <p>Duration: {test_results.get('duration', 'N/A')}</p>
                <p>Status: <span class="{'passed' if test_results.get('overall_status') == 'PASS' else 'failed'}">{test_results.get('overall_status', 'UNKNOWN')}</span></p>
            </div>
            
            <p>Please find the detailed test reports attached.</p>
        </body>
        </html>
        """
        return html_content
    
    def send_email(self, test_results, attachments=None):
        """Send email with test results"""
        try:
            # Create message
            msg = MIMEMultipart()
            msg['From'] = self.config['mail']
            msg['To'] = ', '.join(self.config['mail_goal'])
            
            # Subject based on test results
            status = test_results.get('overall_status', 'UNKNOWN')
            subject = f"Robot Framework Test Results - {status} - {datetime.now().strftime('%Y-%m-%d %H:%M')}"
            msg['Subject'] = subject
            
            # Email body
            html_content = self.create_email_content(test_results)
            msg.attach(MIMEText(html_content, 'html'))
            
            # Add attachments
            if attachments:
                for file_path in attachments:
                    if os.path.exists(file_path):
                        with open(file_path, "rb") as attachment:
                            part = MIMEBase('application', 'octet-stream')
                            part.set_payload(attachment.read())
                        
                        encoders.encode_base64(part)
                        part.add_header(
                            'Content-Disposition',
                            f'attachment; filename= {os.path.basename(file_path)}'
                        )
                        msg.attach(part)
            
            # Send email
            server = smtplib.SMTP(self.config['host'], self.config['port'])
            server.starttls()
            server.login(self.config['mail'], self.config['password'])
            
            text = msg.as_string()
            server.sendmail(self.config['mail'], self.config['mail_goal'], text)
            server.quit()
            
            print(f"Email sent successfully to {', '.join(self.config['mail_goal'])}")
            return True
            
        except Exception as e:
            print(f"Failed to send email: {str(e)}")
            return False
