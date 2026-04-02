pipeline {
    agent any

    environment {
        APP_NAME = 'jenkins-app'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                echo "Building ${APP_NAME}..."
                sh 'chmod +x scripts/build.sh && scripts/build.sh'
            }
        }

        stage('Test') {
            steps {
                echo 'Running tests...'
                sh 'chmod +x scripts/test.sh && scripts/test.sh'
            }
            post {
                always {
                    junit allowEmptyResults: true, testResults: 'reports/test-results.xml'
                }
            }
        }

        stage('Deploy') {
            when {
                anyOf {
                    branch 'main'
                    branch 'staging'
                }
            }
            environment {
                DEPLOY_ENV = "${env.BRANCH_NAME == 'main' ? 'production' : 'staging'}"
            }
            steps {
                echo "Deploying to ${DEPLOY_ENV}..."
                sh 'chmod +x scripts/deploy.sh && scripts/deploy.sh'
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed. Check the logs for details.'
        }
        always {
            cleanWs()
        }
    }
}
