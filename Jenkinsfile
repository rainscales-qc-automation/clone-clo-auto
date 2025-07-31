pipeline {
    agent any
    
    environment {
        PYTHON_VERSION = '3.10'
        VENV_NAME = 'robot_test_env'
    }
    
    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out code from repository...'
                checkout scm
            }
        }
        
        stage('Setup Python Environment') {
            steps {
                echo 'Setting up Python 3.10 virtual environment...'
                sh '''
                    # Remove existing virtual environment if it exists
                    if [ -d "$VENV_NAME" ]; then
                        rm -rf $VENV_NAME
                    fi
                    
                    # Create new virtual environment with Python 3.10
                    python3.10 -m venv $VENV_NAME
                    
                    # Activate virtual environment and upgrade pip
                    . $VENV_NAME/bin/activate
                    pip install --upgrade pip
                    
                    # Install requirements
                    pip install -r requirements.txt
                    
                    # Verify installation
                    pip list
                '''
            }
        }
        
        stage('Run Robot Framework Tests') {
            steps {
                echo 'Running Robot Framework tests...'
                sh '''
                    # Activate virtual environment
                    . $VENV_NAME/bin/activate
                    
                    # Run tests using the run_tests.py script
                    python run_tests.py
                '''
            }
        }
        
        stage('Archive Results') {
            steps {
                echo 'Archiving test results...'
                // Archive Robot Framework results
                archiveArtifacts artifacts: 'results/**/*', allowEmptyArchive: true
                
                // Publish Robot Framework results if plugin is installed
                script {
                    try {
                        publishRobotFrameworkReports(
                            outputPath: 'results',
                            outputFileName: 'output.xml',
                            reportFileName: 'report.html',
                            logFileName: 'log.html',
                            disableArchiveOutput: false,
                            passThreshold: 80.0,
                            unstableThreshold: 60.0,
                            onlyCritical: false,
                            otherFiles: '**/*.png,**/*.jpg'
                        )
                    } catch (Exception e) {
                        echo "Robot Framework plugin not available, skipping report publishing"
                        echo "Error: ${e.getMessage()}"
                    }
                }
            }
        }
    }
    
    post {
        always {
            echo 'Cleaning up...'
            sh '''
                # Clean up virtual environment
                if [ -d "$VENV_NAME" ]; then
                    rm -rf $VENV_NAME
                fi
            '''
        }
        
        success {
            echo 'Pipeline completed successfully!'
            // You can add email notifications here if needed
        }
        
        failure {
            echo 'Pipeline failed!'
            // You can add failure notifications here
        }
        
        unstable {
            echo 'Pipeline completed with some test failures'
        }
    }
}
