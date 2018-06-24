#!/usr/bin/env bash

set -xe

echo "Remove unnecessary packages..."
yum remove -y vim
yum -y autoremove