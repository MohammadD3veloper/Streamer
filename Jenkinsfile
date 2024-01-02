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
        stage('migrate') {
            steps {
                echo '[*] Running Migrations ...'
                sh "docker run streamer:latest sh -c 'python manage.py migrate'"
            }
        }
        stage('statics') {
            steps {
                echo '[*] Running collectstatics ...'
                sh 'docker run streamer:latest sh -c "python manage.py collectstatic --noinput"'
            }
        }
        stage('addSuperuser') {
            steps {
                sh "docker run streamer:latest sh -c \"export DJANGO_SUPERUSER_EMAIL=${env.SUPERUSER_EMAIL}\""
                sh "docker run streamer:latest sh -c \"export DJANGO_SUPERUSER_PASSWORD=${env.SUPERUSER_PASSWORD}\""
                sh "docker run streamer:latest sh -c \"python manage.py createsuperuser --no-input --username ${env.SUPERUSER_USERNAME}\""
            }
        }
        stage('tagAndPush') {
            steps {
                sh "docker tag streamer:latest ${env.DOCKER_USERNAME}/streamer:latest"
                sh "docker push ${env.DOCKER_REPONAME}/streamer:latest"
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
