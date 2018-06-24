#!/usr/bin/env bash

set -xe

echo "Clear cache..."
yum -y clean all
rm -rf /var/cache/yum
rm -rf /var/tmp/yum-*
rm -rf /headless/.cache
rm -rf .cache
rm -rf /var/log
rm -rf /tmp/*
