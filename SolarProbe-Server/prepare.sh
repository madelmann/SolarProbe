#!/usr/bin/env bash

echo "Preparing environment..."

BASE=$(pwd)

export BASE

envsubst < ${BASE}/config/base.conf.tmp     > ${BASE}/config/base.conf
envsubst < ${BASE}/config/probes.conf.tmp   > ${BASE}/config/probes.conf

cp -r ${BASE}/templates/gifs/ www/

sudo chmod -R 777 ${BASE}/nodes
sudo chmod -R 777 ${BASE}/tmp

echo "Done preparing environment."

