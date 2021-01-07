#!/usr/bin/env bash

# add stretch repo to sources list
echo "deb http://archive.raspbian.org/raspbian stretch main" >> /etc/apt/sources.list

# update package list and install dependencies
apt update
apt install -y multiarch-support libavformat57 git libportaudio2* libflac++6v5* libavahi-common3 libavahi-client3 alsa-utils

# create working folder
mkdir /usr/ifi
cd /usr/ifi

# download and install other needed dependencies
curl -k -O -L http://security.debian.org/debian-security/pool/updates/main/o/openssl/libssl1.0.0_1.0.1t-1+deb8u12_armhf.deb
apt install -y ./libssl1.0.0_1.0.1t-1+deb8u12_armhf.deb
curl -k -O -L http://security.debian.org/debian-security/pool/updates/main/c/curl/libcurl3_7.38.0-4+deb8u16_armhf.deb
apt install -y ./libcurl3_7.38.0-4+deb8u16_armhf.deb

# clone git repo
git clone https://github.com/shawaj/ifi-tidal-release

# correct permissions
chmod +x /usr/ifi/ifi-tidal-release/play
chmod +x /usr/ifi/ifi-tidal-release/bin/tidal_connect_application
chmod +x /usr/ifi/ifi-tidal-release/pa_devs/run.sh

# deploy files
./ifi-tidal-release/file-deploy.sh 

# start service and check on status
systemctl daemon-reload
systemctl start ifi-streamer-tidal-connect.service 
systemctl status ifi-streamer-tidal-connect.service
