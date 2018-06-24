#!/usr/bin/env bash

set -xe

echo "Create a user $1 (uid=10000) in the group $1 (gid=10000)"
adduser -m -u 10000 -U $1
usermod -aG wheel $1
sed -i "\$a$1 ALL=(ALL) NOPASSWD: ALL" /etc/sudoers
chmod u+s /usr/bin/sudo
chown -R $1:$1 /home/$1
