#!/bin/bash

aks-cluster/destroy.sh "wasp-sbx-na-eus2-aks-a"
aks-cluster/destroy.sh "wasp-sbx-na-ceus-aks-a"
environment/destroy.sh "wasp-sbx-na"
