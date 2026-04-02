pipeline {
    agent any
    
    stages {
        stage('Checkout') {
            steps {
                echo '========================================='
                echo '📦 STAGE 1: CHECKOUT'
                echo '========================================='
                checkout scm
                echo "✅ Code checked out successfully"
                echo "📌 Branch: ${env.BRANCH_NAME}"
                echo "📌 Commit: ${env.GIT_COMMIT}"
                echo "📌 Repository: ${env.GIT_URL}"
            }
        }
        
        stage('Build') {
            steps {
                echo '========================================='
                echo '🔨 STAGE 2: MAVEN BUILD'
                echo '========================================='
                sh '''
                    echo "Running mvn clean compile..."
                    mvn clean compile
                '''
                echo '✅ Build completed successfully'
            }
        }
        
        stage('Test') {
            steps {
                echo '========================================='
                echo '🧪 STAGE 3: MAVEN TEST'
                echo '========================================='
                sh '''
                    echo "Running mvn test..."
                    mvn test
                '''
                echo '✅ All tests passed'
            }
        }
    }
    
    post {
        success {
            echo '========================================='
            echo '🎉 PIPELINE SUCCESSFUL!'
            echo '========================================='
            echo '✅ Checkout completed'
            echo '✅ Build completed'
            echo '✅ Tests passed'
        }
        failure {
            echo '========================================='
            echo '💥 PIPELINE FAILED!'
            echo '========================================='
            echo '❌ Please check the logs above'
        }
    }
}
