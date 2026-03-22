#!/bin/bash
sudo chmod +x docker_install.sh
sudo bash docker_install.sh
sudo docker build -t mc-service:v1.20.6 -f Dockerfile-mc . && \
sudo docker run -d --name mc-service-1.20.6 --restart always -p 25565:25565 mc-service:v1.20.6
