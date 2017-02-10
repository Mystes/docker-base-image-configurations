#!/usr/bin/env bash

docker build -f "$1/Dockerfile" -t "mystes/wso2esb:$1" .
