#!/usr/bin/env bash

cd $(dirname $0)/base && \
vagrant up && \
vagrant reload && \
vagrant halt && \
vagrant package --output mybase.box && \
vagrant box add mybase mybase.box && \
rm -f mybase.box

