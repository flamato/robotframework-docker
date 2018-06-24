#!/usr/bin/env bash

set -xe

echo "Install pip2, requirements for python 2..."
curl -Lk https://bootstrap.pypa.io/get-pip.py | python -
yum install -y python-devel
pip install -r requirements.txt
# Rename pybot, rebot, robot, pabot
cp /usr/bin/pybot /usr/bin/pybot2
cp /usr/bin/robot /usr/bin/robot2
cp /usr/bin/rebot /usr/bin/rebot2
cp /usr/bin/pabot /usr/bin/pabot2
