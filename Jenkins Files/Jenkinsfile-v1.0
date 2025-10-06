@Library('ak-libraries') _ 

pipeline {
    agent any

    stages {
        stage('Hello') {
            steps {
                echo 'Hello World'
            }
        }

        stage('Clone Repo') {
            steps {
                script {
                    cloneRepo('https://github.com/ak-devops-anurag-org/simple-nodejs-server-with-dockerFile.git', 'dev')
                }
            }
        }

        stage('who am i') {
            steps {
                echo 'whoami'
                sh 'whoami'
                // sh 'sudo usermod -aG docker $USER && newgrp docker'
            }
        }

        stage('Build Docker Image'){
            steps {
                script {
                    dockerBuild('simple-node-img-jenkins','latest','akdevanurag')
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                echo 'Pushing image to Docker Hub'
                withCredentials([usernamePassword(
                    credentialsId: "dockerHubCreds", 
                    usernameVariable: "dockerHubUsername", 
                    passwordVariable: "dockerHubPass")]) {
                    sh """
                      echo "$dockerHubPass" | docker login -u "$dockerHubUsername" --password-stdin
                      docker push ${dockerHubUsername}/simple-node-img-jenkins:latest
                    """
                }
            }
        }

        stage('Deploy Container') {
            steps {
                echo 'Deploying Docker container'
                sh 'docker compose up -d'
            }
        }
    }
}