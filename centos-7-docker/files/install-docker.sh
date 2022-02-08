# Install other dependencies
sudo yum install -y gcc make openssl-devel ruby docker

# Setup Docker to run without root by creating a local group and adding the vagrant user to it
sudo groupadd docker
sudo usermod -aG docker vagrant

# Enable Docker service
sudo systemctl enable docker

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.28.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Next, we install the Kubernetes CLI

# Download the binary
curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"

# Allow execution of the binary
sudo chmod +x ./kubectl

# Move the binary into the PATH
sudo mv ./kubectl /usr/local/bin/kubectl