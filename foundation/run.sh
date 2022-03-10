#!/bin/bash

export ENVIRONMENT_NAME="wasp-sbx-na"

environment/create.sh "wasp-sbx-na"

aks-cluster/create.sh "wasp-sbx-na-eus2-aks-a"
