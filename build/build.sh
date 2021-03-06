#!/bin/bash

#
# This script is executed inside of a container holding the image during it's build steps
# This means that any script in here will be executed as if it's inside The Element itself!
#

readonly SERVICE_USER=formide
readonly plugin_dir=/opt/plugins
readonly assets_dir=/var/standard-ui

echo "Standard UI setup..."

#Copy necessary assets for Standard UI
echo -n "Copying asset files..."
mkdir -p $assets_dir/testAssets
cp -r ./testAssets/* $assets_dir/testAssets/
echo "Done"

echo -n "Copying splash screen..."
cp ./splash.bmp /boot/splash.bmp
echo "Done"

echo "Installing USB drive plugin from remote..."
cd $plugin_dir
git clone https://github.com/PRINTR3D/formide-client-usb-drive.git # USB drive plugin, has no dependecies
echo "Done"

echo "Done with Standard UI build script"
