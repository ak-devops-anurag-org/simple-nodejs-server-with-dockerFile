# 🧩 Jenkins Declarative Pipeline — Main Blocks Explained

A typical Jenkinsfile looks like this 👇

```groovy
pipeline {
    agent any
    parameters { ... }
    environment { ... }
    stages { ... }
    post { ... }
}
```

Each block has a specific purpose. Let’s go through them one by one with simple examples 👇

## **`pipeline` Block**

### Purpose:

The **root** of every declarative pipeline — defines your entire CI/CD process.

### Example:

```groovy
pipeline {
    agent any
    stages {
        stage('Build') { steps { echo 'Building...' } }
    }
}
```

✅ Everything must be **inside** this block — like stages, environment, post, etc.

## **`agent` Block**

### Purpose:

Defines **where the pipeline runs** — on any node, a specific label, or inside a Docker container.

### Example:

```groovy
agent any              // run on any available Jenkins agent

// OR
agent { label 'docker-node' }   // run only on agents labeled 'docker-node'

// OR run inside a Docker container
agent {
    docker { image 'node:18' }
}
```

✅ Think of this as the “machine” or “environment” your pipeline executes on.

## **`parameters` Block**

### Purpose:

Lets you pass **user inputs** when starting the job.
Makes pipelines **flexible and reusable**.

### Example:

```groovy
parameters {
    string(name: 'BRANCH', defaultValue: 'main', description: 'Git branch to build')
    choice(name: 'ENVIRONMENT', choices: ['dev', 'qa', 'prod'], description: 'Select deployment environment')
    booleanParam(name: 'RUN_TESTS', defaultValue: true, description: 'Run test cases?')
}
```

### Output:

When you click **“Build with Parameters”** in Jenkins, you’ll see input fields for these values.

✅ Useful when you want to:

* Deploy to different environments
* Build different branches
* Turn optional stages ON/OFF

## **`environment` Block**

### Purpose:

Defines **global variables** available across all stages.
You can reuse them with `$VAR` or `env.VAR`.

### Example:

```groovy
environment {
    DOCKER_USER = 'akdevanurag'
    IMAGE_NAME = 'simple-node-img-jenkins'
    IMAGE_TAG = 'latest'
}
```

Then use it inside any stage:

```groovy
sh "docker build -t ${DOCKER_USER}/${IMAGE_NAME}:${IMAGE_TAG} ."
```

✅ Keeps your Jenkinsfile clean and avoids hardcoding values everywhere.

## **`stages` Block**

### Purpose:

Contains a list of **sequential stages** — each stage represents one phase of the pipeline (e.g., Build, Test, Deploy).

### Example:

```groovy
stages {
    stage('Build') {
        steps {
            echo 'Building the project...'
        }
    }

    stage('Test') {
        steps {
            echo 'Running tests...'
        }
    }

    stage('Deploy') {
        steps {
            echo 'Deploying to production...'
        }
    }
}
```

✅ Makes your CI/CD process modular and readable.

## **`when` Block**

### Purpose:

Controls **conditional execution** of stages.
If the condition is false, the stage is skipped.

### Example 1: Simple Expression

```groovy
stage('Push to Docker Hub') {
    when {
        expression { return params.RUN_TESTS }
    }
    steps {
        echo 'Pushing image...'
    }
}
```

### Example 2: Branch-based

```groovy
when { branch 'main' }
```

### Example 3: Environment-based

```groovy
when {
    environment name: 'ENVIRONMENT', value: 'prod'
}
```

✅ Common use: run deploy stage **only on main branch** or **only for production**.

## **`post` Block**

### Purpose:

Defines actions to run **after the pipeline or stage finishes**,
depending on build result (success, failure, always, unstable, aborted).

### Example:

```groovy
post {
    always {
        echo 'Cleaning up workspace...'
        cleanWs()
    }
    success {
        echo 'Pipeline succeeded!'
        sh 'docker image prune -f'
    }
    failure {
        echo 'Pipeline failed. Check logs!'
    }
}
```

✅ Most used for:

* Cleanup
* Sending notifications
* Archiving reports/logs
* Docker cleanup

## **`steps` Block**

### Purpose:

Defines **the actual work** done inside a stage.

### Example:

```groovy
stage('Build') {
    steps {
        sh 'npm install'
        sh 'npm run build'
    }
}
```

✅ Can contain `sh`, `bat`, `echo`, `script {}` and many other commands.

## **`script` Block**

### Purpose:

Used to write **Groovy logic** inside a declarative pipeline.
Without `script {}`, you can’t use normal Groovy `if`, `for`, `try` etc.

### Example:

```groovy
stage('Conditional Step') {
    steps {
        script {
            if (params.RUN_TESTS) {
                echo "Running tests..."
                sh 'npm test'
            } else {
                echo "Skipping tests"
            }
        }
    }
}
```

Use it for dynamic logic that Jenkins declarative syntax can’t directly express.

## **`options` Block** (Bonus)

### Purpose:

Defines pipeline-level options like build timeout, retry count, timestamps, etc.

### Example:

```groovy
options {
    timeout(time: 15, unit: 'MINUTES')
    buildDiscarder(logRotator(numToKeepStr: '10'))
    timestamps()
}
```

Helps with log management and preventing endless builds.

# 🧭 Quick Summary Table

| Block           | Purpose                | Example Use                           |
| --------------- | ---------------------- | ------------------------------------- |
| **pipeline**    | Root of the file       | Defines the full pipeline             |
| **agent**       | Where to run           | `agent any`, `agent { docker {...} }` |
| **parameters**  | Input from user        | Choose branch/env                     |
| **environment** | Global vars            | Docker user, image name               |
| **stages**      | Sequence of steps      | Build → Test → Deploy                 |
| **steps**       | Actual commands        | `sh`, `echo`, `script {}`             |
| **when**        | Conditional execution  | Only run on `main` branch             |
| **post**        | After pipeline actions | Cleanup, notify, prune                |
| **script**      | Groovy logic           | `if/else`, loops                      |
| **options**     | Pipeline behavior      | Timeout, log rotation                 |






## Bonus: tools, libraries, and more
- `tools` block: Defines build tools like specific JDK or Maven version.
- `@Library('my-shared-lib') _` for loading shared libs.


# Full Production-Ready Jenkinsfile Example

```groovy
@Library('ak-libraries') _

pipeline {
    agent any

    options {
        timeout(time: 15, unit: 'MINUTES')
        buildDiscarder(logRotator(numToKeepStr: '20'))
        timestamps()
    }

    parameters {
        string(name: 'GIT_BRANCH', defaultValue: 'dev', description: 'Git branch to clone')
        choice(name: 'DEPLOY_ENV', choices: ['dev', 'qa', 'prod'], description: 'Select deployment environment')
        booleanParam(name: 'PUSH_TO_DOCKERHUB', defaultValue: true, description: 'Push image to Docker Hub?')
    }

    environment {
        REPO_URL    = 'https://github.com/ak-devops-anurag-org/simple-nodejs-server-with-dockerFile.git'
        IMAGE_NAME  = 'simple-node-img-jenkins'
        IMAGE_TAG   = 'latest'
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
                script {
                    cloneRepo(env.REPO_URL, params.GIT_BRANCH)
                }
            }
        }

        stage('Who am I') {
            steps {
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
                    sh """
                        echo "$dockerHubPass" | docker login -u "$dockerHubUsername" --password-stdin
                        docker push ${dockerHubUsername}/${IMAGE_NAME}:${IMAGE_TAG}
                    """
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
```
