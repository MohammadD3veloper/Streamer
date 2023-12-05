pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                script {
                    def filePath = "Streamer"
                    if (fileExists(filePath)) {
                        echo "[*] Streamer exists, Skipping step"
                    } else {
                        echo '[*] Getting updated files'
                        sh "git clone https://github.com/MohammadD3veloper/Streamer"
                    }
                }
            }
        }
        stage('Buildx') {
            steps {
                echo '[*] Building docker image ...'
                sh "docker buildx build -t streamer:latest -f Streamer/Dockerfile Streamer/"
            }
        }
        stage('Lint') {
            steps {
                echo '[*] Running Linter ...'
                sh "docker-compose -f Streamer/docker-compose.yml run django --rm sh -c 'flake8 stramer/'"
            }
        }
        stage('Test') {
            steps {
                echo '[*] Running tests ...'
                sh "docker-compose -f Streamer/docker-compose.yml run django --rm sh -c 'python manage.py tests'"
            }
        }
        stage('migrate') {
            steps {
                echo '[*] Running Migrations ...'
                sh "docker-compose -f Streamer/docker-compose.yml run django --rm sh -c 'python manage.py migrate'"
            }
        }
        stage('statics') {
            steps {
                echo '[*] Running collectstatics ...'
                sh "docker-compose -f Streamer/docker-compose.yml run django --rm sh -c 'python manage.py collectstatics'"
            }
        }
        stage('deploy') {
            steps {
                echo '[*] Deploying Streamer ...'
                sh "docker-compose -f Streamer/docker-compose.yml --rm up"
            }
        }
    }
}
