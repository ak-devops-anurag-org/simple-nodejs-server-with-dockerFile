#!/bin/bash
set -e

echo "================ Updating system ================="
sudo apt-get update -y
sudo apt-get upgrade -y

echo "================ Installing dependencies ================="
sudo apt-get install -y fontconfig openjdk-21-jre apt-transport-https ca-certificates curl gnupg lsb-release

echo "================ Installing Jenkins ================="
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee /etc/apt/keyrings/jenkins-keyring.asc > /dev/null
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update -y
sudo apt-get install -y jenkins

echo "================ Enabling and Starting Jenkins ================="
sudo systemctl enable jenkins
sudo systemctl start jenkins

echo "================ Installing Docker & Docker Compose ================="
sudo apt-get install -y docker.io
sudo usermod -aG docker $USER && newgrp docker 
sudo usermod -aG docker jenkins && newgrp docker 
sudo systemctl enable docker
sudo systemctl start docker

sudo apt-get install -y docker-compose-v2

echo "================ Installation Complete ================="
