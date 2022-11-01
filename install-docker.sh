#!/bin/bash -x

# Install using the repository
# Before you install Docker Engine for the first time on a new host machine, you need to set up the Docker repository. Afterward, you can install and update Docker from the repository.

# Set up the repository
# Update the apt package index and install packages to allow apt to use a repository over HTTPS:

sudo apt-get update
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Add Docker’s official GPG key:

sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Use the following command to set up the repository:

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker Engine
# Update the apt package index, and install the latest version of Docker Engine, containerd, and Docker Compose, or go to the next step to install a specific version:

sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

#Manage Docker as a non-root user
#The Docker daemon binds to a Unix socket instead of a TCP port. By default that Unix socket is owned by the user root and other users can only access it using sudo. The Docker daemon always runs as the root user.

#If you don’t want to preface the docker command with sudo, create a Unix group called docker and add users to it. When the Docker daemon starts, it creates a Unix socket accessible by members of the docker group.

#Warning

#The docker group grants privileges equivalent to the root user. For details on how this impacts security in your system, see Docker Daemon Attack Surface.

#Note:

#To run Docker without root privileges, see Run the Docker daemon as a non-root user (Rootless mode).

#To create the docker group and add your user:

#Create the docker group.

sudo groupadd docker

#Add your user to the docker group.

sudo usermod -aG docker $USER
#Log out and log back in so that your group membership is re-evaluated.

#If testing on a virtual machine, it may be necessary to restart the virtual machine for changes to take effect.

#On a desktop Linux environment such as X Windows, log out of your session completely and then log back in.

#On Linux, you can also run the following command to activate the changes to groups:

newgrp docker
#Verify that you can run docker commands without sudo.

docker run hello-world
#This command downloads a test image and runs it in a container. When the container runs, it prints a message and exits.

#If you initially ran Docker CLI commands using sudo before adding your user to the docker group, you may see the following error, which indicates that your ~/.docker/ directory was created with incorrect permissions due to the sudo commands.

#WARNING: Error loading config file: /home/user/.docker/config.json -
#stat /home/user/.docker/config.json: permission denied
#To fix this problem, either remove the ~/.docker/ directory (it is recreated automatically, but any custom settings are lost), or change its ownership and permissions using the following commands:

 #sudo chown "$USER":"$USER" /home/"$USER"/.docker -R
 #sudo chmod g+rwx "$HOME/.docker" -R

# Configure Docker to start on boot
# Most current Linux distributions (RHEL, CentOS, Fedora, Debian, Ubuntu 16.04 and higher) use systemd to manage which services start when the system boots. On Debian and Ubuntu, the Docker service is configured to start on boot by default. To automatically start Docker and Containerd on boot for other distros, use the commands below:

sudo systemctl enable docker.service
sudo systemctl enable containerd.service

#To disable this behavior, use disable instead.

#sudo systemctl disable docker.service
#sudo systemctl disable containerd.service
