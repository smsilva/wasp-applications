#!/bin/bash
echo ""

SCRIPT_PATH="$(dirname $0)"

mkdir -p "${HOME}/.azure/"

EXTERNAL_DNS_AZURE_FILE="${HOME}/.azure/azure-config-file.json"

cat <<EOF > "${EXTERNAL_DNS_AZURE_FILE?}"
{
  "tenantId": "${ARM_TENANT_ID}",
  "subscriptionId": "${ARM_SUBSCRIPTION_ID}",
  "resourceGroup": "wasp-foundation",
  "aadClientId": "${ARM_CLIENT_ID}",
  "aadClientSecret": "${ARM_CLIENT_SECRET}"
}
EOF

kubectl create namespace external-dns

kubectl \
  --namespace external-dns \
  create secret generic azure-config-file \
    --from-file="${EXTERNAL_DNS_AZURE_FILE?}"

helm repo add external-dns https://kubernetes-sigs.github.io/external-dns/

helm repo update external-dns

helm search repo external-dns

helm upgrade \
  --install \
  --namespace external-dns \
  external-dns external-dns/external-dns \
  --values "${SCRIPT_PATH}/values.yaml"
