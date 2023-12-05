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
                sh "sudo docker buildx build -t streamer:latest -f Streamer/Dockerfile Streamer/"
            }
        }
        stage('Lint') {
            steps {
                echo '[*] Running Linter ...'
                sh "sudo docker-compose -f Streamer/docker-compose.yml run django --rm sh -c 'flake8 stramer/'"
            }
        }
        stage('Test') {
            steps {
                echo '[*] Running tests ...'
                sh "sudo docker-compose -f Streamer/docker-compose.yml run django --rm sh -c 'python manage.py tests'"
            }
        }
        stage('migrate') {
            steps {
                echo '[*] Running Migrations ...'
                sh "sudo docker-compose -f Streamer/docker-compose.yml run django --rm sh -c 'python manage.py migrate'"
            }
        }
        stage('statics') {
            steps {
                echo '[*] Running collectstatics ...'
                sh "sudo docker-compose -f Streamer/docker-compose.yml run django --rm sh -c 'python manage.py collectstatics'"
            }
        }
        stage('deploy') {
            steps {
                echo '[*] Deploying Streamer ...'
                sh "sudo docker-compose -f Streamer/docker-compose.yml --rm up"
            }
        }
    }
}
