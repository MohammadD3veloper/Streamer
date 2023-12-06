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
                sh "docker buildx build -t streamer:latest -f Dockerfile ."
            }
        }
        stage('Lint') {
            steps {
                echo '[*] Running Linter ...'
                sh "docker-compose -f docker-compose.yml run django --rm sh -c 'flake8 stramer/'"
            }
        }
        stage('Test') {
            steps {
                echo '[*] Running tests ...'
                sh "docker-compose -f docker-compose.yml run django --rm sh -c 'python manage.py tests'"
            }
        }
        stage('migrate') {
            steps {
                echo '[*] Running Migrations ...'
                sh "docker-compose -f docker-compose.yml run django --rm sh -c 'python manage.py migrate'"
            }
        }
        stage('statics') {
            steps {
                echo '[*] Running collectstatics ...'
                sh "docker-compose -f docker-compose.yml run django --rm sh -c 'python manage.py collectstatics'"
            }
        }
        stage('deploy') {
            steps {
                echo '[*] Deploying Streamer ...'
                sh "docker-compose -f docker-compose.yml --rm up"
            }
        }
    }
}
