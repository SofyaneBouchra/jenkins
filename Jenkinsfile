pipeline {
    agent any

    environment {
        SLACK_CHANNEL = '#devops'
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
                    env.SHORT_COMMIT = env.GIT_COMMIT ? env.GIT_COMMIT.take(7) : "N/A"
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
                message: "✅ SUCCESS - ${env.JOB_NAME} #${env.BUILD_NUMBER} | Branch: ${env.BRANCH_NAME} | Commit: ${env.SHORT_COMMIT} | ${env.BUILD_URL}"
            )
        }

        failure {
            echo '💥 PIPELINE FAILED!'

            slackSend(
                channel: "${SLACK_CHANNEL}",
                color: 'danger',
                message: "❌ FAILED - ${env.JOB_NAME} #${env.BUILD_NUMBER} | Branch: ${env.BRANCH_NAME} | ${env.BUILD_URL}"
            )
        }

        unstable {
            echo '⚠️ PIPELINE UNSTABLE!'

            slackSend(
                channel: "${SLACK_CHANNEL}",
                color: 'warning',
                message: "⚠️ UNSTABLE - ${env.JOB_NAME} #${env.BUILD_NUMBER} | ${env.BUILD_URL}"
            )
        }

        always {
            echo '📢 Pipeline finished'
        }
    }
}
