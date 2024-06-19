pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('68836c54-2b6a-4439-bf96-27780afad393') // Replace with your Docker Hub credentials ID
    }

    stages {
        stage('Build and Push to Dev') {
            when {
                branch 'dev'
            }
            steps {
                script {
                    sh './build.sh'
                    docker.withRegistry('https://registry.hub.docker.com', DOCKERHUB_CREDENTIALS) {
                        sh 'docker tag jolearner123/devops-build:dev jolearner123/devops-build-dev:latest'
                        sh 'docker push jolearner123/devops-build-dev:latest'
                    }
                }
            }
        }
        stage('Deploy and Push to Prod') {
            when {
                branch 'master'
            }
            steps {
                script {
                    withCredentials([sshUserPrivateKey(credentialsId: 'ec2-ssh-key', keyFileVariable: 'KEYFILE', usernameVariable: 'SSH_USER')]) {
                        // Setting EC2 instance IP as an environment variable
                        env.EC2_INSTANCE_IP = '3.109.49.240'

                        // Execute the deploy.sh script
                        sh '''
                            chmod +x deploy.sh
                            ./deploy.sh
                        '''

                        docker.withRegistry('https://registry.hub.docker.com', DOCKERHUB_CREDENTIALS) {
                            sh 'docker tag jolearner123/devops-build:dev jolearner123/devops-build-prod:latest'
                            sh 'docker push jolearner123/devops-build-prod:latest'
                        }
                    }
                }
            }
        }
    }

    post {
        success {
            echo 'Build and Deployment succeeded!'
        }
        failure {
            echo 'Build or Deployment failed!'
        }
    }
}
