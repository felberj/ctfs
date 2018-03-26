#!/bin/bash

echo "[*] Installing docker..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update
apt-cache policy docker-ce
apt-get install -y docker-ce

echo "[*] Now do the following:"
echo "1. sudo docker swarm init --advertise-addr ...."
echo "2. Start the BYOS service at https://cloud.docker.com/" 
echo "3. docker run -ti --rm -v /var/run/docker.sock:/var/run/docker.sock dockercloud/registration"

