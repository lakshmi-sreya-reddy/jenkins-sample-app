pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/lakshmi-sreya-reddy/jenkins-sample-app.git'

            }
        }

        stage('Build') {
            steps {
                sh 'npm install'
                sh 'npm run build'
            }
        }

        stage('Deploy Simulation') {
            steps {
                echo "Simulating deployment (no real server)..."
                sh 'echo "Deployment complete!"'
            }
        }
    }

    post {
        success {
            echo "Build succeeded! ✅"
        }
        failure {
            echo "Build failed ❌"
        }
    }
}
