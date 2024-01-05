pipeline {

    agent any
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Build') {
            steps {
                echo '[*] Building docker image ...'
                sh "docker buildx build -t streamer:latest -f docker/Dockerfile ."
            }
        }
        stage('Lint') {
            steps {
                echo '[*] Running Linter ...'
                sh "docker run streamer:latest sh -c 'flake8 streamer/'"
            }
        }
        stage('Test') {
            steps {
                echo '[*] Running tests ...'
                sh "docker run streamer:latest sh -c 'python manage.py test'"
            }
        }
        stage('tagAndPush') {
            steps {
                sh "docker tag streamer:latest ${env.DOCKER_USERNAME}/${env.DOCKER_REPONAME}:latest"
                sh "docker push ${env.DOCKER_USERNAME}/${env.DOCKER_REPONAME}:latest"
            }
        }
        stage('deploy') {
            steps {
                echo '[*] Deploying Streamer ...'
                sh "./entrypoint.sh"
            }
        }
    }
}
