#!/bin/sh

# Installs docker and docker-compose if they are missing.
if ! hash docker 2>/dev/null; then        
    sudo curl -fsSL https://get.docker.com | sh -
fi

if ! hash docker-compose 2>/dev/null; then    
    sudo curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/bin/docker-compose
    sudo chmod +x /usr/bin/docker-compose
    docker-compose version  
fi
