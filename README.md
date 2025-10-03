
# Simple Node.js Server with Docker

This project is a simple Node.js server built using Express.js. It exposes a few basic routes and is containerized using Docker. The server listens on **port 8085**.

---

## 🧾 Features

- `GET /` → Returns a simple welcome message
- `GET /hello` → Returns a greeting from API
- `GET /status` → Returns a JSON object indicating server health

---

## 📁 Project Structure

```

simple-nodejs-server-with-dockerFile/
├── Dockerfile
├── index.js
├── package.json
└── README.md

````

---

## 🛠️ Prerequisites

- [Node.js](https://nodejs.org/)
- [Docker](https://www.docker.com/)
- [Jenkins](https://www.jenkins.io/) (for CI/CD, optional)

---

## 🚀 Run Locally

### 1. Install Dependencies

```bash
npm install
````

### 2. Start the Server

```bash
node index.js
```

Server will be running on:

```
http://localhost:8085
```

---

## 🐳 Run with Docker

### 1. Build Docker Image

```bash
docker build -t node-img .
```

### 2. Run Docker Container

```bash
docker run -d -p 8085:8085 --name node-container node-img
```

---

## 🔁 API Endpoints

| Method | Endpoint  | Description                |
| ------ | --------- | -------------------------- |
| GET    | `/`       | Root route (Hello message) |
| GET    | `/hello`  | Sample API endpoint        |
| GET    | `/status` | Returns server status      |

---

## 🧪 Sample Output

### `/status`

```json
{
  "status": "Server is running fine."
}
```

---

## ⚙️ Jenkins CI/CD Pipeline (Example)

```groovy
pipeline {
    agent any

    stages {
        stage('Clone') {
            steps {
                git url: 'https://github.com/your-org/simple-nodejs-server-with-dockerFile.git', branch: 'dev'
            }
        }
        stage('Build') {
            steps {
                sh 'docker build -t node-img .'
            }
        }
        stage('Deploy') {
            steps {
                sh 'docker rm -f node-container || true'
                sh 'docker run -d -p 8085:8085 --name node-container node-img'
            }
        }
    }
}
```

---

## 🧹 Cleanup

Stop and remove the container:

```bash
docker rm -f node-container
```

Remove the Docker image:

```bash
docker rmi node-img
```
