#!/usr/bin/env bash
export DOCKER_GATEWAY_HOST="$(hostname) |awk '{print $1}'"
docker run -it \
        --network host \
        -v ${PWD}/test.py:/scripts/test.py \
        -v ${PWD}/config/spark-defaults.conf:/opt/spark/conf/spark-defaults.conf \
        derivedai/spark:3.0.1-hive-3.0.0-hadoop-3.3.0 \
        /bin/bash