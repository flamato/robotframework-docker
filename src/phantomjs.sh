#!/usr/bin/env bash

set -xe

echo "Installing phantomjs v$1..."
mkdir -p /opt/phantomjs
wget -qO- --no-check-certificate --delete-after https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-$1-linux-x86_64.tar.bz2 | tar -xj --strip-components 1 -C /opt/phantomjs
ln -s /opt/phantomjs/bin/phantomjs /usr/bin/phantomjs
