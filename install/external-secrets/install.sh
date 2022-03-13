#!/bin/bash
echo ""

SCRIPT_PATH="$(dirname $0)"

EXTERNAL_SECRETS_VERSION="0.4.4"

helm repo add --force-update external-secrets https://charts.external-secrets.io

helm repo update external-secrets

helm search repo external-secrets

helm install \
  external-secrets external-secrets/external-secrets \
  --version "${EXTERNAL_SECRETS_VERSION?}" \
  --namespace external-secrets \
  --create-namespace \
  --wait

# Service Principal
ARM_CLIENT_ID_BASE64=$(     echo ${ARM_CLIENT_ID}     | base64 )
ARM_CLIENT_SECRET_BASE64=$( echo ${ARM_CLIENT_SECRET} | base64 )

cat <<EOF | kubectl apply -f -
---
apiVersion: v1
kind: Secret
metadata:
  name: azurerm-service-principal
type: Opaque
data:
  ARM_CLIENT_ID: ${ARM_CLIENT_ID_BASE64}
  ARM_CLIENT_SECRET: ${ARM_CLIENT_SECRET_BASE64}
---
apiVersion: external-secrets.io/v1alpha1
kind: ClusterSecretStore
metadata:
  name: azure-subscription-key-vault
spec:
  provider:
    azurekv:
      authType: ServicePrincipal

      tenantId: ${ARM_TENANT_ID}
      vaultUrl: https://${ARM_KEYVAULT_NAME}.vault.azure.net

      authSecretRef:
        clientId:
          key: ARM_CLIENT_ID
          name: azurerm-service-principal
          namespace: default

        clientSecret:
          key: ARM_CLIENT_SECRET
          name: azurerm-service-principal
          namespace: default
EOF
