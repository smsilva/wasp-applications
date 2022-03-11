#!/bin/bash
SCRIPT_PATH="$(dirname $0)"

EXTERNAL_DNS_AZURE_FILE="${CREDENTIALS_DIRECTORY?}/azure/azure.json"

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

helm upgrade \
  --install \
  --namespace external-dns \
  external-dns bitnami/external-dns \
  --set "provider=azure" \
  --set "azure.secretName=azure-config-file" \
  --set "podSecurityContext.enabled=true" \
  --set "podSecurityContext.runAsUser=0" \
  --set "podSecurityContext.fsGroup=0"
