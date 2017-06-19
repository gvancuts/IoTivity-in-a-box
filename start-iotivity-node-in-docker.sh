#!/bin/bash

# project home directory
PROJ_HOME=/opt/IoTivity-in-a-box

# directory for user code
USER_DIR=/opt/user

# Print out container IP address
echo "This container IP address is: `hostname -i`"

# Set-up the path to where the node.js modules were installed
export NODE_PATH=$PROJ_HOME/node_modules/

# Install dependencies from a user's package.json file
if [ -f "$USER_DIR/package.json" ];
then
	/usr/bin/npm install $USER_DIR
fi

# Start the user application
if [ -z "$1" ];
then
    echo "No JavaScript application argument given."
    if [ -f "$USER_DIR/index.js" ];
    then
	    echo "index.js file found, attempting to use it..."
	    /usr/bin/nodejs "$USER_DIR/index.js" &
    else
	    echo "Please provide a .js file to be used."
    fi
elif [ -f "$USER_DIR/$1" ];
then
	echo "Starting $1..."
	/usr/bin/nodejs "$USER_DIR/$1" &
else
	echo "Could not find the $1 file... please double-check your mount volume and filename."
fi

keepgoing=true

trap "keepgoing=false" SIGINT

echo "Press [CTRL+C] to stop.."

while $keepgoing
do
	:
done
