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
                sh "docker run -i -t streamer:latest sh -c 'flake8 streamer/'"
            }
        }
        stage('Test') {
            steps {
                echo '[*] Running tests ...'
                sh "docker run -i -t streamer:latest sh -c 'python manage.py test'"
            }
        }
        stage('migrate') {
            steps {
                echo '[*] Running Migrations ...'
                sh "docker run -i -t streamer:latest sh -c 'python manage.py migrate'"
            }
        }
        stage('statics') {
            steps {
                echo '[*] Running collectstatics ...'
                sh "docker-compose -f docker/docker-compose.yml run django sh -c
                                                'python manage.py collectstatic --noinput'"
                sh "docker run -i -t streamer:latest sh -c
                                    'python manage.py collectstatic --noinput'"
            }
        }
        stage('addSuperuser') {
            steps {
                sh "docker run -i -t streamer:latest sh -c 'export 
                    DJANGO_SUPERUSER_EMAIL=${env.SUPERUSER_EMAIL}  &&
                        export DJANGO_SUPERUSER_PASSWORD=${env.SUPERUSER_PASSWORD} &&
                            python manage.py createsuperuser --no-input
                            --username ${env.SUPERUSER_USERNAME}'"
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
