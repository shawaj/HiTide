#!/usr/bin/env bash

echo "deb http://archive.raspbian.org/raspbian stretch main" >> /etc/apt/sources.list
apt update
apt install -y multiarch-support libavformat57 git libportaudio2* libflac++6v5* libavahi-common3 libavahi-client3 alsa-utils
mkdir /usr/ifi
cd /usr/ifi
curl -k -O -L http://security.debian.org/debian-security/pool/updates/main/o/openssl/libssl1.0.0_1.0.1t-1+deb8u12_armhf.deb
apt install ./libssl1.0.0_1.0.1t-1+deb8u12_armhf.deb
curl -k -O -L http://security.debian.org/debian-security/pool/updates/main/c/curl/libcurl3_7.38.0-4+deb8u16_armhf.deb
apt install ./libcurl3_7.38.0-4+deb8u16_armhf.deb
git clone https://github.com/shawaj/ifi-tidal-release
chmod +x /usr/ifi/ifi-tidal-release/play
chmod +x /usr/ifi/ifi-tidal-release/bin/tidal_connect_application
chmod +x /usr/ifi/ifi-tidal-release/pa_devs/run.sh
    
cd /usr/ifi
./ifi-tidal-release/file-deploy.sh 

systemctl daemon-reload
systemctl start ifi-streamer-tidal-connect.service 
systemctl status ifi-streamer-tidal-connect.service
