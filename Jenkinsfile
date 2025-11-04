pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-creds')
        IMAGE_NAME = 'lakshmisreyareddy/nodejs-sample-app'
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Cloning source code...'
                git url: 'https://github.com/lakshmi-sreya-reddy/jenkins-sample-app.git', branch: 'main'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'npm install'
            }
        }

        stage('Security Scan - Gitleaks') {
            steps {
                sh '''
                echo "Running Gitleaks scan..."
                docker run --rm -v $(pwd):/repo zricethezav/gitleaks:latest detect --source /repo --no-git
                '''
            }
        }

        stage('Security Scan - Trivy') {
            steps {
                sh '''
                echo "Running Trivy scan..."
                docker run --rm -v /var/run/docker.sock:/var/run/docker.sock -v $(pwd):/app aquasec/trivy image node:18
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                echo "Building Docker image..."
                docker build -t $IMAGE_NAME:latest .
                '''
            }
        }

        stage('Push to DockerHub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                    echo "Pushing image to DockerHub..."
                    echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                    docker push $IMAGE_NAME:latest
                    '''
                }
            }
        }

        stage('Deploy using Docker Compose') {
            steps {
                sh '''
                echo "Deploying with Docker Compose..."
                docker-compose down || true
                docker-compose up -d
                '''
            }
        }
    }

    post {
        success {
            echo '✅ Pipeline completed successfully!'
        }
        failure {
            echo '❌ Pipeline failed. Please check logs.'
        }
    }
}
