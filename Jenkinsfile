pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo '[*] Building docker image ...'
                sh "docker build -t streamer:latest"
            }
        }
        stage('Lint') {
            steps {
                echo '[*] Running Linter ...'
                sh "docker-compose run django sh -c 'flake8 stramer/'"
            }
        }
        stage('Test') {
            steps {
                echo '[*] Running tests ...'
                sh "docker-compose run django sh -c 'python manage.py tests'"
            }
        }
        stage('migrate') {
            steps {
                echo '[*] Running Migrations ...'
                sh "docker-compose run django sh -c 'python manage.py migrate'"
            }
        }
        stage('statics') {
            steps {
                echo '[*] Running collectstatics ...'
                sh "docker-compose run django sh -c 'python manage.py collectstatics'"
            }
        }
        stage('deploy') {
            steps {
                echo '[*] Deploying Streamer ...'
                sh "docker-compose up"
            }
        }
    }
}
