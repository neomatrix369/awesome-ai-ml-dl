#!/bin/bash

sudo yum install -y git

# Open ports for the services to communicate
sudo firewall-cmd --zone=public --permanent --add-port=8080-8085/tcp
sudo firewall-cmd --zone=public --permanent --add-port=8443/tcp
sudo firewall-cmd --reload

git clone https://github.com/neomatrix369/awesome-ai-ml-dl
cd awesome-ai-ml-dl/examples/tribuo
./docker-runner.sh --pullImageFromHub

echo "|-----------------------------------------------------------------------------------------------------|"
echo "|                                                                                                     |"
echo "| ssh onto the OCI box followed by the below command:                                                 |"
echo "|                                                                                                     |"
echo "|       $ ./run-docker-container-in-the-cloud.sh                                                       |"
echo "|                                                                                                     |"
echo "|-----------------------------------------------------------------------------------------------------|"