#!/usr/bin/env bash
# Copyright (c) 2015 Jeff Denton
# The LICENSE file is located in the top level directory.

set -x

# Install Python 3.4.2 (which includes pip3)
PYTHON_URL="https://www.python.org/ftp/python/3.4.2/Python-3.4.2.tgz"
PYTHON_DIR="Python-3.4.2"

if [ ! -d "/opt/$PYTHON_DIR/bin" ]; then
  # Install Python dependencies (that will surely come in handy later)
  yum install -y zlib-devel openssl-devel sqlite-devel bzip2-devel

  mkdir /tmp/python_install && \
  cd /tmp/python_install && \
  wget -nv $PYTHON_URL && \
  tar -xzf ${PYTHON_DIR}.tgz && \
  cd $PYTHON_DIR && \
  ./configure --prefix=/opt/$PYTHON_DIR && \
  make -j$(nproc) && \
  make install && \
  echo "export PATH=/opt/$PYTHON_DIR/bin:\$PATH" > /etc/profile.d/python3.sh

  rm -rf /tmp/python_install
else
  echo "Python is already installed under /opt/$PYTHON_DIR/. Exiting."
fi
