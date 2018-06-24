#!/usr/bin/env bash

set -xe

echo "Install python 3.x, pip3, requirements..."
yum install -y yum-utils
yum install -y https://centos7.iuscommunity.org/ius-release.rpm
yum install -y python36u
curl -Lk https://bootstrap.pypa.io/get-pip.py | python3.6 -
yum install -y python36u-devel
pip3 install -r requirements.txt
# Rename pybot, rebot, robot, pabot
mv /usr/bin/pybot /usr/bin/pybot3
mv /usr/bin/robot /usr/bin/robot3
mv /usr/bin/rebot /usr/bin/rebot3
mv /usr/bin/pabot /usr/bin/pabot3
