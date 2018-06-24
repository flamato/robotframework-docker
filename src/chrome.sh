#!/usr/bin/env bash

set -xe

echo "Installing chrome v$1..."
yum remove -y chromium
yum remove -y chromium*
rm -f ~/Desktop/chromium-browser.desktop
if [ "$1" == "latest" ]; then
    echo -e '[google-chrome]\nname=google-chrome\nbaseurl=http://dl.google.com/linux/chrome/rpm/stable/$basearch\nenabled=1\ngpgcheck=1\ngpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub' | tee /etc/yum.repos.d/google-chrome.repo
    wget --no-check-certificate https://dl-ssl.google.com/linux/linux_signing_key.pub
    rpm --import linux_signing_key.pub
    rm -f linux_signing_key.pub
    yum install -y google-chrome-stable;
else
    wget -q --no-check-certificate http://orion.lcg.ufrj.br/RPMS/myrpms/google/google-chrome-stable-$1.x86_64.rpm
    yum localinstall -y google-chrome-stable-$1.x86_64.rpm
    rm -f google-chrome-stable-$1.x86_64.rpm;
fi

wget -q --no-check-certificate https://chromedriver.storage.googleapis.com/$2/chromedriver_linux64.zip
unzip chromedriver_linux64.zip -d /usr/bin/
rm -f chromedriver_linux64.zip
sed -i 's/\"$@\"/\"$@\" --no-sandbox/' /opt/google/chrome/google-chrome
