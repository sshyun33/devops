#!/bin/bash

# Define variables
DOMAIN=www.project9.com
CERT_FILE=./certs/${DOMAIN}.crt
KEY_FILE=./private/${DOMAIN}.key
DHPARAM_FILE=./certs/dhparam-2048.pem

# Create directory
mkdir -p ${CERT_FILE%/*};
mkdir -p ${KEY_FILE%/*};
chmod 700 ${KEY_FILE%/*}

# Create a self-signed key and certificate pair
if [[ ! -r ${KEY_FILE} ]]; then
  openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ${KEY_FILE} -out ${CERT_FILE}
fi

# Create Diffie-Hellman parameter
if [[ ! -r  ${DHPARAM_FILE} ]]; then
  openssl dhparam -out ${DHPARAM_FILE} 2048
fi
