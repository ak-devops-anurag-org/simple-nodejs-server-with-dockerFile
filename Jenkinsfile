@Library('ak-libraries') _

pipeline {
    agent any

    parameters {
        string(name: 'GIT_BRANCH', defaultValue: 'dev', description: 'Git branch to clone')
        choice(name: 'DEPLOY_ENV', choices: ['dev', 'qa', 'prod'], description: 'Select deployment environment')
        booleanParam(name: 'PUSH_TO_DOCKERHUB', defaultValue: true, description: 'Push image to Docker Hub?')
    }

    environment {
        REPO_URL = 'https://github.com/ak-devops-anurag-org/simple-nodejs-server-with-dockerFile.git'
        IMAGE_NAME = 'simple-node-img-jenkins'
        IMAGE_TAG = 'latest'
        DOCKER_USER = 'akdevanurag'
    }

    stages {
        stage('Hello') {
            steps {
                echo "👋 Hi! - Deploying for environment: ${params.DEPLOY_ENV}"
            }
        }

        stage('Clone Repo') {
            steps {
                withCredentials([string(credentialsId: 'repoUrl', variable: 'repoURL')]) {                  
                    script {
                        // cloneRepo(repoURL, params.GIT_BRANCH)
                        cloneRepo(env.REPO_URL, params.GIT_BRANCH)
                    }
                }
            }
        }

        stage('Who am I') {
            steps {
                echo "Current users"
                sh 'whoami'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerBuild(env.IMAGE_NAME, env.IMAGE_TAG, env.DOCKER_USER)
                }
            }
        }

        stage('Push to Docker Hub') {
            when {
                expression { return params.PUSH_TO_DOCKERHUB }
            }
            steps {
                echo '📦 Pushing image to Docker Hub...'
                withCredentials([usernamePassword(
                    credentialsId: "dockerHubCreds", 
                    usernameVariable: "dockerHubUsername", 
                    passwordVariable: "dockerHubPass")]) {
                    sh '''
                        echo "$dockerHubPass" | docker login -u "$dockerHubUsername" --password-stdin
                        docker push ${dockerHubUsername}/${IMAGE_NAME}:${IMAGE_TAG}
                    '''
                }
            }
        }

        stage('Deploy Container') {
            when {
                anyOf {
                    expression { params.DEPLOY_ENV == 'dev' }
                    expression { params.DEPLOY_ENV == 'qa' }
                }
            }
            steps {
                echo "🚀 Deploying container for ${params.DEPLOY_ENV} environment"
                sh 'docker compose up -d'
            }
        }
    }

    post {
        always {
            echo '📦 Cleaning workspace...'
            cleanWs()
        }

        success {
            echo '✅ Pipeline succeeded!'
            // Clean old Docker images after successful run
            sh '''
                echo "🧹 Cleaning up old Docker images..."
                docker image prune -f
                docker container prune -f
            '''
        }

        failure {
            echo '❌ Pipeline failed! Check logs for details.'
        }
    }
}
