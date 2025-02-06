# Use the official Jenkins image as a base image
FROM jenkins/jenkins:lts

# Install dependencies
USER root
RUN apt-get update && apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    sudo \
    && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo tee /etc/apt/trusted.gpg.d/docker.asc > /dev/null \
    && echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list \
    && apt-get update \
    && apt-get install -y docker-ce docker-ce-cli containerd.io \
    && rm -rf /var/lib/apt/lists/*

# Add Jenkins user to the Docker group
RUN usermod -aG docker jenkins

# Change the working directory
WORKDIR /var/jenkins_home

# Set the default user
USER jenkins

# Expose port
EXPOSE 8080
