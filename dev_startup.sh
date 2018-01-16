#!/bin/sh

# set up a central log directory so we can tail logs easily
mkdir -p ./logs

# start all essential service
sudo service couchdb start
consul agent -dev -config-dir=etc/consul.d -enable-script-checks=true -ui 2>&1 > logs/consul.log &
vault server -config=etc/vault.hcl 2>&1 > logs/vault.log &
echo "Started all services ..."
