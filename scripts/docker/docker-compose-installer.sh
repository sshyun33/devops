#!/bin/bash

DOCKER_COMPOSE_VERSION=1.11.2

checkDockerCompose() {
  if [[ $(docker-compose --version 2>/dev/null |awk -F '[ ,]' '{print $3}') \
      == "${DOCKER_COMPOSE_VERSION}" ]]; then
    return 0;
  else
    return 1;
  fi
}

# install docker-compose
if ! checkDockerCompose; then
  sudo sh -c 'curl -L https://github.com/docker/compose/releases/download/\'${DOCKER_COMPOSE_VERSION}'/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose'
  sudo chmod +x /usr/local/bin/docker-compose
fi
