#!/bin/sh

DOMAIN=ec2.rohaky.com
CERT_DAY=365

echo "*** 1. Create CA private Key ***"
openssl genrsa -aes256 -out ca-key.pem 4096

echo "\n*** 2. Create CA public key ***"
openssl req -new -x509 -days $CERT_DAY -key ca-key.pem -sha256 -out ca.pem

echo "\n*** 3. Create Server private key ***"
openssl genrsa -out server-key.pem 4096 
echo "\n*** 4. Create Server CSR ***"
openssl req -subj "/CN=$DOMAIN" -sha256 -new -key server-key.pem -out server.csr

echo "\n*** 5. Create Server certificate ***"
# Set IP to accept 
#echo subjectAltName = DNS:$DOMAIN,IP:10.10.10.20,IP:127.0.0.1 > extfile.cnf

openssl x509 -req -days $CERT_DAY -sha256 -in server.csr -CA ca.pem -CAkey ca-key.pem -CAcreateserial -out server-cert.pem # -extfile extfile.cnf

echo "\n*** 6. Create Client private key ***"
openssl genrsa -out key.pem 4096

echo "\n*** 7. Create Client CSR ***"
openssl req -subj '/CN=client' -new -key key.pem -out client.csr

echo "\n*** 8. Create Client certificate ***"
echo extendedKeyUsage = clientAuth > extfile.cnf
openssl x509 -req -days $CERT_DAY -sha256 -in client.csr -CA ca.pem -CAkey ca-key.pem -CAcreateserial -out cert.pem -extfile extfile.cnf

echo "\n*** 9. Remove CSR and change file permission ***"
rm -f client.csr server.csr ca.srl extfile.cnf
chmod 0400 ca-key.pem key.pem server-key.pem
chmod 0444 ca.pem server-cert.pem cert.pem

echo "\n*** Complete to create TLS keys & certificates ***"

echo "\n***************************** To Do Next *************************************"
echo "*** [Server]                                                               ***"
echo "*** 1. \$sudo vi /etc/systemd/system/multi-user.target.wants/docker.service ***"
echo "*** 2. ExecStart=/usr/bin/dockerd -H fd:// -H tcp://[CLIENT_IP]:2376 \     ***"
echo "***    --tlsverify --tlscacert=[PATH]/ca.pem \                             ***"
echo "***    --tlscert=[PATH]/server-cert.pem \                                  ***"
echo "***    --tlskey=[PATH]/server-key.pem                                      ***"
echo "*** 3. \$sudo systemctl daemon-realod                                       ***"
echo "*** 4. \$sudo systemctl restart docker                                      ***"
echo "*** 5. \$sudo systemctl status docker                                       ***"
echo "***                                                                        ***"
echo "*** [Client]                                                               ***"
echo "*** 6. copy ca.pem, cert.pem, key.pem to ~/.docker directory               ***"
echo "*** 7. \$export DOCKER_HOST=tcp://SERVER_IP:2376 DOCKER_TLS_VERIFY=1        ***"
echo "*** 8. (option) \$export DOCKER_CERT_PATH=~/.docker/path/                   ***"
echo "*** 9. \$docker version                                                     ***"
echo "******************************************************************************"

