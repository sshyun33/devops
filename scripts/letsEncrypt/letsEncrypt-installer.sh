#!/bin/bash

DOMAIN=project9.rohaky.com

#sudo apt-get install -y letsencrypt

#sudo letsencrypt certonly --standalone -d ${DOMAIN}

if [[ -d /etc/letsencrypt ]]; then
  sudo cp -a /etc/letsencrypt/archive/${DOMAIN}/fullchain1.pem
  sudo cp -a /etc/letsencrypt/archive/${DOMAIN}/fullchain1.pem
fi
