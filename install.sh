#!/bin/bash

set -x
set -e

ODOMETER_VERSION='v0.4.6'
JQUERY_VERSION='1.11.1'

HOME_DIR='/home/pi'


sudo apt-get install unclutter xdotool git-core screen apache2

if [ -d "wiringPi" ]; then
    pushd wiringPi
    git pull
else
    git clone git://git.drogon.net/wiringPi
    pushd wiringPi
fi

sudo rm -rf /usr/local/bin/gpio

./build

popd


mkdir -p /etc/xdg/lxsession/LXDE/
sudo cp autostart/system /etc/xdg/lxsession/LXDE/autostart

mkdir -p ${HOME_DIR}/.config/lxsession/LXDE/
cp autostart/user ${HOME_DIR}/.config/lxsession/LXDE/autostart

cp -rf sensorscanner.sh website ${HOME_DIR}/

pushd ${HOME_DIR}

pushd website
wget https://raw.github.com/HubSpot/odometer/${ODOMETER_VERSION}/odometer.js -O odometer.js
wget https://raw.github.com/HubSpot/odometer/${ODOMETER_VERSION}/themes/odometer-theme-car.css -O odometer-theme-car.css
wget http://code.jquery.com/jquery-${JQUERY_VERSION}.min.js -O jquery.js
touch counter.txt
popd
popd

