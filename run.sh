#!/usr/bin/env bash
set -euo pipefail

BROKER_ROOT=$(cd $(dirname $0); pwd)

cd $BROKER_ROOT
cd compose
docker-compose stop
cd ..
docker build -q -t broker/python-base -f images/restapi/Dockerfile .
cd compose
docker-compose up -d
docker-compose logs -f
