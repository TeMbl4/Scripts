#!/usr/bin/env bash

git_daemon_user="git"
git_daemon_group="git"
git_daemon_enable="YES"
git_daemon_directory="/home/git"
git_daemon_flags="--base-path=/home/git --export-all --max-connections=100 --syslog --reuseaddr --detach"


mkdir -p /home/git
chown -R git:git /home/git
chmod 755 /home/git

mkdir /home/git/.ssh
chmod 700 /home/git/.ssh
cat <PUB_KEY> >> /home/git/.ssh/authorized_keys
chown  -R git:git /home/git/.ssh

mkdir /home/git/repos/test.git
cd /home/git/repos/test.git
git init --bare --shared
chown -R git:git /home/git/repos/test.git

pw groupadd -n git
pw useradd -n git -g git -c git -d /home/git -s /usr/local/libexec/git-core/git-shell -h -

pw usermod <YOURS USER> -G git

/usr/local/etc/rc.d/git_daemon restart
