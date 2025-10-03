// pipeline {
//     agent any

//     stages {
//         stage('Hello') {
//             steps {
//                 echo 'Hello World'
//             }
//         }

//         stage('code') {
//             steps {
//                 echo 'Clone a gitHub repos'
//                 git url: 'https://github.com/ak-org-2002/simple-nodejs-server-with-dockerFile.git', branch: 'dev'
//             }
//         }

//         stage('who am i') {
//             steps {
//                 echo 'whoami'
//                 sh 'whoami'
//                 // sh 'sudo usermod -aG docker $USER && newgrp docker'
//             }
//         }

//         stage('Build Docker Image') {
//             steps {
//                 echo 'Building Docker image'
//                 sh 'docker build -t node-img .'
//             }
//         }

//         stage('Push to Docker Hub') {
//             steps {
//                 echo 'Pushing image to Docker Hub'
//                 withCredentials([usernamePassword(
//                   credentialsId: "dockerHubCreds", 
//                   usernameVariable: "dockerHubUsername", 
//                   passwordVariable: "dockerHubPass")]) 
//                   {
//                     sh "docker login -u ${dockerHubUsername} -p ${dockerHubPass}"
//                     sh "docker image tag node-img ${dockerHubUsername}/simple-node-img-jenkins:latest"
//                     sh "docker push ${dockerHubUsername}/simple-node-img-jenkins:latest"
//                 }
//             }
//         }

//         stage('Deploy Container') {
//             steps {
//                 echo 'Deploying Docker container'
//                 sh 'docker compose up -d'
//             }
//         }
//     }
// }
