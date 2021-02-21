#!/bin/bash

apt-get update
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"

apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io

systemctl enable docker
systemctl start docker

useradd --uid 1000 --create-home --home-dir /opt/valheim valheim
gpasswd --add valheim docker

mount ${device} /opt/valheim || true
chown -R valheim: /opt/valheim
