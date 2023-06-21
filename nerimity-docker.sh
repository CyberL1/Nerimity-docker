#!/bin/bash

print_help() {
  cat <<EOF
$0 up - Starts nerimity-docker
$0 update - Updates the containers to latest version of nerimity
$0 build - Builds the containers with custom changes
$0 down - Removes all containers created by nerimity-docker WARNING: database will be wiped
EOF
}

get_latest_release() {
    curl --silent "https://api.github.com/repos/Nerimity/nerimity-$1/releases/latest" |
    grep '"tag_name":' |
    sed -E 's/.*"([^"]+)".*/\1/'
}

# Variables

BASE_URL="https://github.com/Nerimity"

SERVER_REPO="$BASE_URL/nerimity-server"
CLIENT_REPO="$BASE_URL/nerimity-web"
CDN_REPO="$BASE_URL/nerimity-cdn"

SERVER_VERSION="$(get_latest_release server)"
CLIENT_VERSION="$(get_latest_release web)"

SERVER_DIR="$PWD/server/nerimity-server"
CLIENT_DIR="$PWD/client/nerimity-web"
CDN_DIR="$PWD/cdn/nerimity-cdn"

# Auto troubleshoot

if [ ! -d $SERVER_DIR ]; then
  echo Nerimity server is missing, getting latest release..
  git clone $SERVER_REPO -b $SERVER_VERSION $SERVER_DIR
  echo Done.
fi

if [ ! -d $CLIENT_DIR ]; then
  echo Nerimity client is missing, getting latest release...
  git clone $CLIENT_REPO -b $CLIENT_VERSION $CLIENT_DIR
  echo Done.
fi

if [ ! -d $CDN_DIR ]; then
  echo Nerimity CDN is missing, getting latest release...
  git clone $CDN_REPO $CDN_DIR
  mv $CDN_DIR/example.config.js $CDN_DIR/config.js
  echo Done.
fi

# Commands

command_up() {
  sudo docker compose up
}

command_update() {
  echo Updatin grepos...

  echo Updating server...
  cd $SERVER_DIR
  git pull origin $SERVER_VERSION

  echo Updating client...
  cd $CLIENT_DIR
  git pull origin $CLIENT_VERSION

  echo Updating CDN...
  cd $CDN_DIR
  git pull

  echo Nerimity-docker updated, run using $0 up
}

command_build() {
  sudo docker compose build
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
