#!/bin/bash

JAVA_VERSION=1.8.0_121
JAVA_DOWNLOAD=http://download.oracle.com/otn-pub/java/jdk/8u121-b13/e9e7ea248e2c4826b92b3f075a80e441/jdk-8u121-linux-x64.tar.gz
JAVA_HOME=/usr/lib/jvm/java-${JAVA_VERSION}-oracle
TEMP_DIR=/tmp/jdk-install-temp

if [[ $(which java) ]]; then
 echo "Java was already installed..."
 exit 1
fi

# Create temp directory
pushd .
sudo rm -rf ${TEMP_DIR}
mkdir ${TEMP_DIR} && cd ${TEMP_DIR}

# Download jdk
wget --continue --no-check-certificate --header "Cookie: oraclelicense=a" \
  ${JAVA_DOWNLOAD}

# Extract jdk file
tar -xf jdk-*.tar.gz

# Move java home directory
sudo mkdir -p ${JAVA_HOME%/*}
sudo mv jdk*[^z] ${JAVA_HOME}

# Set java binary path
sudo update-alternatives --install /usr/bin/java java ${JAVA_HOME}/jre/bin/java 1091
sudo update-alternatives --install /usr/bin/javac javac ${JAVA_HOME}/bin/javac 1091

# Set java environment variable
echo "JAVA_HOME=${JAVA_HOME}" |sudo tee /etc/profile.d/java.sh
echo "PATH=\${PATH}:${JAVA_HOME}:/bin" |sudo tee -a /etc/profile.d/java.sh

# Clear
rm -rf ${TEMP_DIR}
popd
