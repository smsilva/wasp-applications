#!/bin/bash
echo ""

SCRIPT_PATH="$(dirname $0)"

helm repo add jetstack https://charts.jetstack.io &> /dev/null
helm repo update jetstack &> /dev/null
helm search repo jetstack

helm upgrade \
  --install \
  --namespace cert-manager \
  --create-namespace \
  --set installCRDs=true \
  cert-manager jetstack/cert-manager \
  --wait

# helm upgrade \
#   --install \
#   --namespace cert-manager \
#   cert-manager-issuers "./charts/cert-manager-issuers/"
