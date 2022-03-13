#!/bin/bash
echo ""

SCRIPT_PATH="$(dirname $0)"

helm repo add jetstack https://charts.jetstack.io

helm repo update jetstack

helm search repo jetstack

helm upgrade \
  --install \
  --namespace cert-manager \
  --create-namespace \
  --set installCRDs=true \
  cert-manager jetstack/cert-manager \
  --wait

kubectl --namespace cert-manager apply --filename "${SCRIPT_PATH}/cluster-issuers.yaml"
