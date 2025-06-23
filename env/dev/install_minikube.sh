#!/bin/bash

# Update package list
sudo apt-get update -y

# Install dependencies
sudo apt-get install -y curl apt-transport-https docker.io conntrack

# Download Minikube
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
rm minikube-linux-amd64

# Download and install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -Ls https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/

# Add current user to docker group (change 'ubuntu' to your actual username if different)
sudo usermod -aG docker $USER

# Change ownership of docker.sock (helpful for avoiding permission issues when using 'none' driver)
sudo chown $USER:$USER /var/run/docker.sock

# Start Minikube with none driver (requires root privileges for 'none')
# --force is risky; avoid unless you know the impact
sudo -E minikube start --driver=none
