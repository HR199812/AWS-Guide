#!/bin/bash

#download node and npm
#sudo apt install nodejs
curl -sL https://deb.nodesource.com/setup_16.x -o nodesource_setup.sh
sudo bash nodesource_setup.sh
sudo apt install nodejs
node -v
sudo apt install npm

#create our working directory if it doesnt exist
DIR="/home/ubuntu/pathlab"
if [ -d "$DIR" ]; then
  echo "${DIR} exists"
else
  echo "Creating ${DIR} directory"
  mkdir ${DIR}
fi