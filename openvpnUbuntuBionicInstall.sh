#!/bin/bash
FILE=~/mongodb-org-server_3.6.20_amd64.deb
if [ -f "$FILE" ]; then
    echo "$FILE exists."
else
    wget https://mirror.yandex.ru/mirrors/repo.mongodb.org/apt/ubuntu/dists/bionic/mongodb-org/3.6/multiverse/binary-amd64/mongodb-org-server_3.6.20_amd64.deb
    dpkg -i mongodb-org-server_3.6.20_amd64.deb
fi
sudo tee /etc/apt/sources.list.d/pritunl.list << EOF
deb https://repo.pritunl.com/stable/apt bionic main
EOF

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 7568D9BB55FF9E5287D586017AE645C0CF8E292A
apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 0C49F3730359A14518585931BC711F9BA15703C6
apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 7568D9BB55FF9E5287D586017AE645C0CF8E292A
apt-get --assume-yes update
apt-get --assume-yes upgrade
apt-get --assume-yes install pritunl
systemctl start pritunl mongod
systemctl enable pritunl mongod
rm -f mongodb-org-server_3.6.20_amd64.deb
