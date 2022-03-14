#!/bin/bash
echo ""

SCRIPT_PATH="$(dirname $0)"

kubectl create namespace external-dns

kubectl \
  --namespace external-dns \
  apply \
  --filename "${SCRIPT_PATH}/azure-config-file.yaml"

helm repo add external-dns https://kubernetes-sigs.github.io/external-dns/

helm repo update external-dns

helm search repo external-dns

helm upgrade \
  --install \
  --namespace external-dns \
  external-dns external-dns/external-dns \
  --values "${SCRIPT_PATH}/values.yaml" \
  --wait
