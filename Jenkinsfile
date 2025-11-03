pipeline {
    agent any

    environment {
        APP_NAME = "jenkins-sample-app"
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Cloning repository from GitHub...'
                git branch: 'main',
                    url: 'https://github.com/lakshmi-sreya-reddy/jenkins-sample-app.git',
                    credentialsId: 'github-token'
            }
        }

        stage('Build') {
            steps {
                echo 'Installing dependencies...'
                sh 'npm install'
            }
        }

        stage('Test') {
            steps {
                echo 'Running tests (if any)...'
                sh 'echo "No tests configured, skipping..."'
            }
        }

        stage('Deploy Simulation') {
            steps {
                echo 'Simulating deployment (for assignment)...'
                sh '''
                    echo "Stopping old app..."
                    echo "Deploying new version..."
                    echo "App deployed successfully!"
                '''
            }
        }
    }

    post {
        success {
            echo '✅ Build succeeded! Sending success email (simulation)...'
        }
        failure {
            echo '❌ Build failed! Sending failure email (simulation)...'
        }
    }
}
