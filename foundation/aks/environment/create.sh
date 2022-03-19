#!/bin/bash

export STACK_INSTANCE_NAME=${ENVIRONMENT_NAME}

stackrun silviosilva/azure-wasp-foundation:0.1.0 apply \
  -auto-approve \
  -var="name=${ENVIRONMENT_NAME}"
