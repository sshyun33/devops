#!/bin/bash

# Define variables
DOMAIN=project9.rohaky.com
CERT_FILE=./certs/${DOMAIN}.fullchain.crt
KEY_FILE=./private/${DOMAIN}.key
DHPARAM_FILE=./certs/dhparam-2048.pem

# Create directories
mkdir -p ${CERT_FILE%/*};
mkdir -p ${KEY_FILE%/*};
chmod 700 ${KEY_FILE%/*}

# Reguest Lets's Encrypt Certificate
if [[ ! -d /etc/letsencrypt ]]; then
  sudo apt-get install -y letsencrypt
  sudo letsencrypt certonly --standalone -d ${DOMAIN}
fi

# Copy certificate and key
if [[ -d /etc/letsencrypt ]]; then
  sudo cp -a /etc/letsencrypt/archive/${DOMAIN}/fullchain1.pem ${CERT_FILE}
  sudo cp -a /etc/letsencrypt/archive/${DOMAIN}/privkey1.pem ${KEY_FILE}
fi

# Create Diffie-Hellman parameter
if [[ ! -r  ${DHPARAM_FILE} ]]; then
  openssl dhparam -out ${DHPARAM_FILE} 2048
fi
