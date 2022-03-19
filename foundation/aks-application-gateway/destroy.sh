#!/bin/bash
set -e

export DIRECTORY_NAME="$(dirname ${0})"
export SCRIPTS_DIRECTORY="${PWD}/${DIRECTORY_NAME}/scripts"
export PATH=${PATH}:${SCRIPTS_DIRECTORY}

. load_parameters

show_parameters

stackrun ${STACK_AKS_IMAGE_NAME?} \
  apply -destroy -no-color -auto-approve

echo ""
echo "OK"
echo ""
