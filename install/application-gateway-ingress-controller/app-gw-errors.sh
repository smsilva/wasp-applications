#!/bin/bash

# The Common Name (CN) of the backend server certificate does not match the host header entered in the health probe configuration (v2 SKU) or the FQDN in the backend pool (v1 SKU). Verify if the hostname matches with the CN of the backend server certificate. To learn more visit - https://aka.ms/backendcertcnmismatch.

# https://docs.microsoft.com/en-us/azure/application-gateway/application-gateway-backend-health-troubleshooting#backend-certificate-invalid-common-name-cn

# The root certificate of the server certificate used by the backend does not match the trusted root certificate added to the application gateway. Ensure that you add the correct root certificate to whitelist the backend

# Code="ErrorUnknownSecretType" Message="secret [argocd-infra/argocd-secret] is not type kubernetes.io/tls

# The root certificate of the server certificate used by the backend does not match the trusted root certificate added to the application gateway. Ensure that you add the correct root certificate to whitelist the backend

openssl ecparam \
  -out certificate.key \
  -name prime256v1 \
  -genkey

openssl req \
  -new \
  -sha256 \
  -key certificate.key \
  -out certificate.csr

openssl x509 \
  -req \
  -sha256 \
  -days 365 \
  -in certificate.csr \
  -signkey certificate.key \
  -out certificate.crt

cp certificate.crt certificate.cer

kubectl create secret tls argocd-secret-tls \
  --cert=certificate.crt  \
  --key=certificate.key

openssl x509 \
  -in "certificate.crt" \
  -text \
  -noout > "certificate.crt.txt"

# The root certificate of the server certificate used by the backend does not match the trusted root certificate added to the application gateway. Ensure that you add the correct root certificate to whitelist the backend

APP_GATEWAY_NAME="wasp-sbx-na-eus2-blue"
APP_GATEWAY_RG_NAME="wasp-sbx-na-eus2-blue"

az network application-gateway root-cert \
  create \
  --cert-file "argocd-blue-eastus2-sandbox-wasp-silvios-me-combined.cer"  \
  --name "argocd-blue-eastus2-sandbox-wasp-silvios-me-combined" \
  --gateway-name ${APP_GATEWAY_NAME?}  \
  --resource-group ${APP_GATEWAY_RG_NAME}

az network application-gateway root-cert \
  list \
  --gateway-name ${APP_GATEWAY_NAME?}  \
  --resource-group ${APP_GATEWAY_RG_NAME} \
  --query '[].name'

az network application-gateway root-cert \
  delete \
  --name "argocd-blue-eastus2-sandbox-wasp-silvios-me-root.cer" \
  --gateway-name ${APP_GATEWAY_NAME?}  \
  --resource-group ${APP_GATEWAY_RG_NAME}

# Export trusted root certificate (for v2 SKU):
# https://docs.microsoft.com/en-us/azure/application-gateway/certificates-for-backend-authentication#export-trusted-root-certificate-for-v2-sku

# End-to-end TLS with the v2 SKU
# https://docs.microsoft.com/en-us/azure/application-gateway/ssl-overview#end-to-end-tls-with-the-v2-sku

openssl pkcs12 \
  -export \
  -in mycertificate.pem \
  -out mycertificate.pfx

openssl pkcs12 \
  -export \
  -out certificate.pfx \
  -inkey privkey.pem \
  -in cert.pem \
  -certfile chain.pem

openssl pkcs12 \
  -export \
  -out argocd-blue-eastus2-sandbox-wasp-silvios-me.pfx \
  -inkey argocd-blue-eastus2-sandbox-wasp-silvios-me.key \
  -in argocd-blue-eastus2-sandbox-wasp-silvios-me.crt \
  -certfile argocd-blue-eastus2-sandbox-wasp-silvios-me-chain.crt

kubectl \
  --namespace argocd-infra \
  delete secret argocd-tls-letsencrypt-production

kubectl \
  --namespace argocd-infra \
  create secret tls argocd-tls-letsencrypt-production \
  --cert=argocd-blue-eastus2-sandbox-wasp-silvios-me-combined.crt \
  --key=argocd-blue-eastus2-sandbox-wasp-silvios-me.key

kubectl run -it --image=alpine/openssl openssl

s_client \
  -connect 10.246.0.103:8080 \
  -servername argocd-server \
  -showcerts

s_client \
  -connect argocd-server:80 \
  -servername argocd-server \
  -showcerts

s_client \
  -connect 10.246.0.28:8080 \
  -servername argocd-blue.eastus2.sandbox.wasp.silvios.me \
  -showcerts

###############################

kubectl \
  -n argocd-infra run \
  -it \
  --image=alpine/openssl openssl

cat \
  sectigo-certificate.cer \
  sectigo-rsa.cer \
  sectigo-root.cer > sectigo-certificate-combined.cer

kubectl \
  -n argocd-infra \
  delete secret argocd-secret

kubectl \
  -n argocd-infra \
  create secret tls argocd-secret \
  --cert=sectigo-certificate-combined.cer \
  --key=sectigo-key.cer

kubectl \
  -n argocd-infra \
  annotate es argocd-secret force-sync=$(date +%s) \
  --overwrite

kubectl \
  -n argocd-infra get deploy argocd-server

kubectl \
  -n argocd-infra rollout restart deploy argocd-server

openssl pkcs12 \
  -in argocd.sandbox.wasp.silvios.me.pfx \
  -nocerts \
  -out private.key

kubectl \
  -n argocd-infra run \
  -it \
  --image=alpine/openssl openssl

kubectl \
  create secret tls argocd-tls-prod \
  --cert=argocd-blue.eastus2.sandbox.wasp.silvios.me.pem \
  --key=argocd-blue.eastus2.sandbox.wasp.silvios.me.key \
  --namespace argocd-infra
