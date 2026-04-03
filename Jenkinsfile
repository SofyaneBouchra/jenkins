pipeline {
    agent any

    environment {
        SLACK_CHANNEL = '#jenkins'
    }

    options {
        timestamps()
    }

    stages {

        stage('Checkout') {
            steps {
                echo '========================================='
                echo '📦 STAGE 1: CHECKOUT'
                echo '========================================='
                
                checkout scm
                
                script {
                    env.SHORT_COMMIT = env.GIT_COMMIT.take(7)
                }

                echo "✅ Code checked out successfully"
                echo "📌 Branch: ${env.BRANCH_NAME}"
                echo "📌 Commit: ${env.SHORT_COMMIT}"
                echo "📌 Repository: ${env.GIT_URL}"
            }
        }

        stage('Build') {
            steps {
                echo '========================================='
                echo '🔨 STAGE 2: MAVEN BUILD'
                echo '========================================='
                
                sh 'mvn clean compile'
                
                echo '✅ Build completed successfully'
            }
        }

        stage('Test') {
            steps {
                echo '========================================='
                echo '🧪 STAGE 3: MAVEN TEST'
                echo '========================================='
                
                sh 'mvn test'
                
                echo '✅ All tests passed'
            }
        }
    }

    post {

        success {
            echo '🎉 PIPELINE SUCCESSFUL!'

            slackSend(
                channel: "${SLACK_CHANNEL}",
                color: 'good',
                message: """✅ *SUCCESS*
Job: ${env.JOB_NAME}
Build: #${env.BUILD_NUMBER}
Branch: ${env.BRANCH_NAME}
Commit: ${env.SHORT_COMMIT}
Duration: ${currentBuild.durationString}
🔗 ${env.BUILD_URL}"""
            )
        }

        failure {
            echo '💥 PIPELINE FAILED!'

            slackSend(
                channel: "${SLACK_CHANNEL}",
                color: 'danger',
                message: """❌ *FAILED*
Job: ${env.JOB_NAME}
Build: #${env.BUILD_NUMBER}
Branch: ${env.BRANCH_NAME}
🔗 ${env.BUILD_URL}"""
            )
        }

        unstable {
            slackSend(
                channel: "${SLACK_CHANNEL}",
                color: 'warning',
                message: """⚠️ *UNSTABLE*
Job: ${env.JOB_NAME}
Build: #${env.BUILD_NUMBER}
🔗 ${env.BUILD_URL}"""
            )
        }

        always {
            echo '📢 Pipeline finished'
        }
    }
}
