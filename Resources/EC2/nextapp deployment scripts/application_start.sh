#!/bin/bash

#give permission for everything in the express-app directory
sudo chmod -R 777 /home/ubuntu/pathlab

#navigate into our working directory where we have all our github files
cd /home/ubuntu/pathlab

#add npm and node to path
#export NVM_DIR="$HOME/.nvm"	
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # loads nvm	
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # loads nvm bash_completion (node is in path now)

#install node modules
#npm install --force

#start our node app in the background
#node server/server.js > app.out.log 2> app.err.log < /dev/null & 
#NODE_ENV=production node server/server.js > app.out.log 2> app.err.log < /dev/null &
cd ./frontend 
npm run start > app.out.log 2> app.err.log < /dev/null &
cd ../backend
node server.js > backendapp.out.log 2> backendapp.err.log < /dev/null &