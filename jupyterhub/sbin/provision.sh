#!/usr/bin/env bash
# Copyright (c) 2015 Jeff Denton
# The LICENSE file is located in the top level directory.

set -x

# Note: keep this consistent with install_python.sh script
#PYTHON_DIR="Python-3.4.2"

# Jupyterhub requires npm to obtain the proxy
yum -y install npm && \
npm install -g configurable-http-proxy && \

# Both Python and JupyterHub are installed when the base is created.
#/opt/$PYTHON_DIR/bin/pip3 install jupyterhub

# Copy over custom iptables file and restart iptables service
cp /vagrant/jupyterhub/etc/sysconfig/iptables /etc/sysconfig/iptables
service iptables restart

# Copy over custom JupyterHub config file
mkdir /etc/jupyterhub
cp /vagrant/jupyterhub/etc/jupyterhub/jupyterhub_config.py /etc/jupyterhub/jupyterhub_config.py

# Install service file and enable at boot
cp /vagrant/jupyterhub/etc/init.d/jupyterhub /etc/init.d/jupyterhub
chkconfig jupyterhub on

# Start Service
service jupyterhub restart
