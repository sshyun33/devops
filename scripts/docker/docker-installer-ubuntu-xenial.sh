#!/bin/bash

UBUNTU_VERSION=xenial
DOCKER_COMPOSE_VERSION=1.10.0
DOCKER_USER=vagrant

COMMON_PKG=(
git
tree
)

checkDockerCompose() {
  if [[ $(docker-compose --version 2>/dev/null |awk -F '[ ,]' '{print $3}') \
      == "${DOCKER_COMPOSE_VERSION}" ]]; then
    return 0;
  else
    return 1;
  fi
}


# install common packages
for i in ${COMMON_PKG[@]}; do
  sudo apt-get -y install $i
done



# install latest docker-engine
sudo apt-get -y install apt-transport-https \
                       ca-certificates

curl -fsSL https://yum.dockerproject.org/gpg | sudo apt-key add -


sudo add-apt-repository \
       "deb https://apt.dockerproject.org/repo/ \
       ubuntu-${UBUNTU_VERSION} \
       main"

sudo apt-get update

sudo apt-get -y install docker-engine


# install docker-compose
if ! checkDockerCompose; then
  sudo sh -c 'curl -L https://github.com/docker/compose/releases/download/1.10.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose'
  sudo chmod +x /usr/local/bin/docker-compose
fi

# add vagrant user to docker group
sudo usermod -aG docker ${DOCKER_USER}
