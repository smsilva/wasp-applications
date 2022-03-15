#!/bin/bash
echo ""

SCRIPT_PATH="$(dirname $0)"

helm repo add jetstack https://charts.jetstack.io
echo ""

helm repo update jetstack
echo ""

helm search repo jetstack
echo ""

helm upgrade \
  --install \
  --namespace cert-manager \
  --create-namespace \
  --set installCRDs=true \
  --version "${CERT_MANAGER_VERSION}" \
  cert-manager jetstack/cert-manager \
  --wait

kubectl --namespace cert-manager apply --filename "${SCRIPT_PATH}/cluster-issuers.yaml"
