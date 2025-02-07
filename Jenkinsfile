pipeline {
    agent any
    
    environment {
        DOCKER_CREDENTIALS = 'docker-hub-creds'  // The ID of your Docker Hub credentials in Jenkins
        DOCKER_IMAGE_frontend = 'sayedkhaledelhawary/frontend-jenkins'  // Your Docker Hub repository name
        DOCKER_IMAGE_backend = 'sayedkhaledelhawary/backend-jenkins'  // Your Docker Hub repository name
        GIT_REPO = 'https://github.com/Selhawary/CI-CD-2.git'  // Your Git repository URL
    }

    stages {
        stage('Clone Git Repo') {
            steps {
                script {
                    // Clone the Git repository
                    echo 'Cloning Git repository...'
                    git url: "$GIT_REPO", branch: 'main'  // Change the branch if needed
                }
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    echo 'Building Docker image...'
                    
                    // Build Docker image from Dockerfile in the repository
                    sh """
                    cd frontend
                    docker build -t $DOCKER_IMAGE_frontend .
                    cd .. 
                    cd backend
                    docker build -t $DOCKER_IMAGE_backend .
                    cd ..
                    """
                }
            }
        }
        


        
        stage('Push Docker Image') {
            steps {
                script {
                    echo 'Pushing Docker image to Docker Hub...'
                    
                    // Push the Docker image to Docker Hub
                    sh 'docker push $DOCKER_IMAGE_frontend'
                    sh 'docker push $DOCKER_IMAGE_backend'
                }
            }
        }
    
    
    
        stage('Deploy') {
            steps {
                script {
                    // Apply Kubernetes deployment using kubectl
                    sh """
                    cd k8s
                    kubectl apply -f .
                    """
                }
            }
        }
        
    }    
    




    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}


