pipeline {
    agent any

    environment {
        DOCKERHUB = credentials('dockerhub')
        IMAGE = "trend-app"
        USER = "skc26"
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/sowmyakc26/Trend.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t $IMAGE:v1 ."
            }
        }

        stage('Docker Login') {
            steps {
                sh '''
                echo $DOCKERHUB_PSW | docker login -u $DOCKERHUB_USR --password-stdin
                '''
            }
        }

        stage('Push Image') {
            steps {
                sh "docker tag $IMAGE:v1 $USER/$IMAGE:v1"
                sh "docker push $USER/$IMAGE:v1"
            }
        }

        stage('Deploy to EKS') {
            steps {
                sh "kubectl apply -f k8s/deployment.yaml"
                sh "kubectl apply -f k8s/service.yaml"
            }
        }
    }
}
