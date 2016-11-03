#!/bin/bash
set -e

# Copy default ESB artifacts into the deployment dir IF it is empty.
# If it's a mounted volume, it may already have content and copying
# is skipped.
if [ ! "$(ls -A $ESB_DEPLOY_DIR)" ]; then
    cp -R /synapse-configs-base/* $ESB_DEPLOY_DIR
fi

if [ "$1" = 'wso2server.sh' ]; then
    echo "pwd: $(pwd)"
    exec wso2server.sh "$@"
fi

exec "$@"
