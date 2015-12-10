#!/usr/bin/env bash
# Copyright (c) 2015 Jeff Denton
# The LICENSE file is located in the top level directory.

set -x

# Note: keep this consistent with install_python.sh script in this directory.
PYTHON_DIR="Python-3.4.2"

yum -y update && \
yum -y install epel-release htop man && \
yum -y groupinstall 'Development Tools' && \
/vagrant/sbin/install_python.sh && \
/opt/$PYTHON_DIR/bin/pip3 install ipython jupyter jupyterhub

# Disable password authentication support setting of sshd (it it is not already present)
grep -q -F 'PasswordAuthentication no' /etc/ssh/sshd_config || \
  echo 'PasswordAuthentication no' >> /etc/ssh/sshd_config && \
  service sshd restart

# The true base box doesn't come with a password set for the vagrant user.
# By default it uses a key only.
# This sets the password of user "vagrant" to "vagrant".
echo -e "vagrant\nvagrant" | (passwd --stdin vagrant)

# Change root password from 'puppet' to 'root' for user 'root'.
echo -e "root\nroot" | (passwd --stdin root)

# Setup ssh key to access the other vm
cp /vagrant/keys/* /home/vagrant/.ssh/              && \
chmod 600 /home/vagrant/.ssh/id_rsa                 && \
chmod 644 /home/vagrant/.ssh/id_rsa.pub             && \
chown vagrant:vagrant /home/vagrant/.ssh/id_rsa*

# Note: remove the broken symlink caused by using vagrant-cachier, which messes up vagrant-vbguest) without the following fix
rm -f /var/cache/yum

dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY
rm -f /root/.bash_history /home/vagrant/.bash_history
