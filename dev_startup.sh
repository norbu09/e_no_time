#!/bin/sh

# set up a central log directory so we can tail logs easily
mkdir -p ./logs

# start all essential service
consul agent -dev -config-dir=etc/consul.d -enable-script-checks=true -ui 2>&1 > logs/consul.log
