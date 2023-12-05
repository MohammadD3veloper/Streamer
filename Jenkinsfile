pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo '[*] Building docker image ...'
                sh "docker build --rm --pull -t streamer:latest -f Dockerfile"
            }
        }
        stage('Lint') {
            steps {
                echo '[*] Running Linter ...'
                sh "docker-compose run django --rm sh -c 'flake8 stramer/'"
            }
        }
        stage('Test') {
            steps {
                echo '[*] Running tests ...'
                sh "docker-compose run django --rm sh -c 'python manage.py tests'"
            }
        }
        stage('migrate') {
            steps {
                echo '[*] Running Migrations ...'
                sh "docker-compose run django --rm sh -c 'python manage.py migrate'"
            }
        }
        stage('statics') {
            steps {
                echo '[*] Running collectstatics ...'
                sh "docker-compose run django --rm sh -c 'python manage.py collectstatics'"
            }
        }
        stage('deploy') {
            steps {
                echo '[*] Deploying Streamer ...'
                sh "docker-compose --rm up"
            }
        }
    }
}
