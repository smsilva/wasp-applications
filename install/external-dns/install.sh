#!/bin/bash
echo ""

SCRIPT_PATH="$(dirname $0)"

kubectl create namespace external-dns

kubectl \
  --namespace external-dns \
  apply \
  --filename "${SCRIPT_PATH}/azure-config-file.yaml"

helm repo add external-dns https://kubernetes-sigs.github.io/external-dns/
echo ""

helm repo update external-dns
echo ""

helm search repo external-dns
echo ""

helm upgrade \
  --install \
  --namespace external-dns \
  external-dns external-dns/external-dns \
  --version "${EXTERNAL_DNS_VERSION?}" \
  --values "${SCRIPT_PATH}/values.yaml" \
  --wait
