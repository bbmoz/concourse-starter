#!/bin/bash

set -e

tunnel () {
  set -x
  ./ngrok-env/run.sh start
  direnv allow
}

keys () {
  set -x
  mkdir -p keys/web keys/worker
  ssh-keygen -t rsa -f ./keys/web/tsa_host_key -N ''
  ssh-keygen -t rsa -f ./keys/web/session_signing_key -N ''
  ssh-keygen -t rsa -f ./keys/worker/worker_key -N ''
  cp ./keys/worker/worker_key.pub ./keys/web/authorized_worker_keys
  cp ./keys/web/tsa_host_key.pub ./keys/worker
}

start () {
  set -x
  docker-compose up -d
  docker-compose ps
}

stop () {
  set -x
  docker-compose stop
}

all () {
  set -x
  tunnel
  keys
  start
}

usage () {
cat <<EOF
  Usage:
    tunnel|t    start tunnel
    keys|k      generate keys
    start|sta   start concourse
    stop|sto    stop concourse
    all|a       start tunnel, generate keys, and start concourse
    *           see usage
EOF
}

case $1 in
  tunnel|t)   tunnel    ;;
  keys|k)     keys      ;;
  start|sta)  start     ;;
  stop|sto)   stop      ;;
  all|a)      all       ;;
  *)          usage     ;;
esac
