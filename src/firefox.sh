#!/usr/bin/env bash

set -xe

echo "Installing firefox v$1..."
rm -rf /usr/lib/firefox
rm -f /usr/bin/firefox
rm -f ~/Desktop/firefox.desktop
wget -qO- --no-check-certificate --delete-after https://ftp.mozilla.org/pub/mozilla.org/firefox/releases/$1/linux-x86_64/en-US/firefox-$1.tar.bz2 | tar xj -C /usr/lib
ln -s /usr/lib/firefox/firefox /usr/bin/firefox
wget -qO- --no-check-certificate --delete-after https://github.com/mozilla/geckodriver/releases/download/v$2/geckodriver-v$2-linux64.tar.gz | tar xz -C /usr/local/bin/
