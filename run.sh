#!/usr/bin/env bash
set -euo pipefail

BROKER_ROOT=$(cd $(dirname $0); pwd)
MODE=${1:-test}

if [ ! -f $BROKER_ROOT/compose/.env ]; then
    echo The file $BROKER_ROOT/compose/.env is missing. Copy $BROKER_ROOT/config/broker.env.template to $BROKER_ROOT/compose/.env and set the values.
    exit 1
fi

cd $BROKER_ROOT
cd compose/$MODE
./dc.sh stop
cd $BROKER_ROOT
docker build -q -t broker/python-base -f images/restapi/Dockerfile .
cd compose/$MODE
./dc.sh up -d
./dc.sh logs -f
