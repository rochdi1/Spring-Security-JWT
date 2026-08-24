pipeline {
    agent any
    
    tools {
        maven 'Maven3' // Must match the name configured in Jenkins Global Tool Configuration
    }
    
    environment {
        DOCKER_IMAGE = "rochdi1/jwt-security-api"
        IMAGE_TAG = "${BUILD_NUMBER}"
    }
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Unit Tests') {
            steps {
                sh 'mvn clean test'
            }
        }
        
        stage('SonarQube Quality Gate') {
            steps {
                // Ensure you have configured the SonarQube server in Jenkins settings
                withSonarQubeEnv('SonarQube') {
                    sh 'mvn sonar:sonar -Dsonar.projectKey=jwt-security-api'
                }
            }
        }
        
        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${DOCKER_IMAGE}:${IMAGE_TAG} ."
                sh "docker tag ${DOCKER_IMAGE}:${IMAGE_TAG} ${DOCKER_IMAGE}:latest"
            }
        }
        
        stage('Push to Registry') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'rochdi1', passwordVariable: '123456789')]) {
                    sh "echo ${PASS} | docker login -u ${USER} --password-stdin"
                    sh "docker push ${DOCKER_IMAGE}:${IMAGE_TAG}"
                    sh "docker push ${DOCKER_IMAGE}:latest"
                }
            }
        }
        
        stage('Deploy to Kubernetes') {
            steps {
                // Applies the deployment manifest to your Kubernetes Cluster
                sh "sed -i 's|IMAGE_PLACEHOLDER|${DOCKER_IMAGE}:${IMAGE_TAG}|g' k8s-deployment.yml"
                sh "kubectl apply -f k8s-deployment.yml"
            }
        }
    }
}
