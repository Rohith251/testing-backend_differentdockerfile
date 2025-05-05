pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'rohith0702/forex-backend'
        DOCKER_TAG = 'latest'
        DOCKER_USER = 'rohith0702'  // Your Docker Hub username
        DOCKER_PASS = 'Rohith@0702'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                sh 'docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} .'
            }
        }

        stage('Push Docker Image') {
            steps {
                sh '''
                echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                docker tag ${DOCKER_IMAGE}:${DOCKER_TAG} ${DOCKER_USER}/${DOCKER_IMAGE}:${DOCKER_TAG}
                docker push ${DOCKER_USER}/${DOCKER_IMAGE}:${DOCKER_TAG}
                '''
            }
        }

        stage('Deploy') {
            steps {
                sh 'docker-compose -f docker-compose.backend.yml down || true'
                sh 'docker-compose -f docker-compose.backend.yml up -d'
            }
        }
    }
}
