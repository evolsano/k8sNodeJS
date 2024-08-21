#!/bin/bash

# Exit on any error
set -e

# Backup and replace source list
sudo cp /etc/apt/sources.list.d/ubuntu.sources /etc/apt/sources.list.d/ubuntu.sources.bak
sudo sed -i 's/ap-southeast-1.ec2.//g' /etc/apt/sources.list.d/ubuntu.sources

# Update system
sudo apt update && sudo apt upgrade -y

# Install docker
sudo apt-get install docker.io -y

# Add User
sudo usermod -aG docker $USER
newgrp docker

# Download kubectl
sudo curl -L "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

# Install kubectl
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Download minikube
sudo curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64

# Install minikube
sudo install minikube-linux-amd64 /usr/local/bin/minikube

# Start minikube
minikube start

# Download Node Image
docker pull volseona/demo-node-app
