#!/usr/bin/env bash
# Copyright (c) 2015 Jeff Denton
# The LICENSE file is located in the top level directory.

set -x

# Note: keep this consistent with install_python.sh script in this directory.
PYTHON_DIR="Python-3.4.2"

yum -y update && \
yum -y install epel-release.noarch && \
yum -y groupinstall 'Development Tools' && \
yum -y install npm && \
npm install -g configurable-http-proxy && \
/vagrant/sbin/install_python.sh && \
/opt/$PYTHON_DIR/bin/pip3 install ipython jupyter jupyterhub

# Other usefull pkgs for development and testing
yum -y install htop man

# If you want to be able to test the JupyterHub installation as the vagrant user...
# This box doesn't come with a password set for the vagrant user. By default it uses a key only.
# This sets the password of user "vagrant" to "vagrant".
echo -e "vagrant\nvagrant" | (passwd --stdin vagrant)

# Copy over custom iptables file + Restart (we access port 8000 from a browser)
#chkconfig iptables off
cp /vagrant/etc/sysconfig/iptables /etc/sysconfig/iptables
service iptables restart

# TODO setup configuration
# NOTE using default configuration for now.

# Install Service File + Enable at boot
cp /vagrant/etc/init.d/jupyterhub /etc/init.d/jupyterhub
chkconfig jupyterhub on

# Clean up
yum clean all
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY
rm -f /root/.bash_history /home/vagrant/.bash_history

# Start Service
#service jupyterhub start
