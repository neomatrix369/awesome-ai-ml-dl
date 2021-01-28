#!/bin/bash

# Create a docker user and add the opc user to it
# This will allow us to call docker commands without sudo
groupadd docker
usermod -aG docker opc

# Install docker
yum install -y docker-engine
systemctl start docker
systemctl enable docker