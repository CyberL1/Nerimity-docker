#!/bin/bash

print_help() {
  cat <<EOF
$0 up - Starts nerimity-docker
$0 update - Updates the containers to latest version of nerimity
$0 build - Builds the containers with custom changes
$0 down - Removes all containers created by nerimity-docker WARNING: database will be wiped
EOF
}

# Variables

BASE_URL="https://github.com/Nerimity"

SERVER_REPO="$BASE_URL/nerimity-server"
CLIENT_REPO="$BASE_URL/nerimity-web"
CDN_REPO="$BASE_URL/nerimity-cdn-ts"

SERVER_DIR="$PWD/server/nerimity-server"
CLIENT_DIR="$PWD/client/nerimity-web"
CDN_DIR="$PWD/cdn/nerimity-cdn-ts"

# Auto troubleshoot

if [ ! -d $SERVER_DIR ]; then
  echo Nerimity server is missing, getting latest release..
  git clone $SERVER_REPO $SERVER_DIR
  echo Done.
fi

if [ ! -d $CLIENT_DIR ]; then
  echo Nerimity client is missing, getting latest release...
  git clone $CLIENT_REPO $CLIENT_DIR
  echo Done.
fi

if [ ! -d $CDN_DIR ]; then
  echo Nerimity CDN is missing, getting latest release...
  git clone $CDN_REPO $CDN_DIR
  echo Done.
fi

# Commands

command_up() {
  sudo docker compose up
}

command_update() {
  echo Updating repos...

  echo Updating server...
  cd $SERVER_DIR
  git pull

  echo Updating client...
  cd $CLIENT_DIR
  git pull

  echo Updating CDN...
  cd $CDN_DIR
  git pull

  echo Nerimity-docker updated, run using $0 up
}

command_build() {
  sudo docker compose build --build-arg VITE_APP_VERSION="$(git -C client/nerimity-web rev-parse HEAD | cut -c -7)"
}

command_down() {
  sudo docker compose down
}

# Command handler lol

if [ $1 ]; then
  command_$1
else
  print_help
fi
