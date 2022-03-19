#!/bin/bash
echo ""

SCRIPT_PATH="$(dirname $0)"

# HTTPBIN_HOST="echo.eastus2.sandbox.wasp.silvios.me"
# INGRESS_CLASS_NAME="nginx"
HTTPBIN_HOST="argocd-blue.eastus2.sandbox.wasp.silvios.me"
INGRESS_CLASS_NAME="azure-application-gateway"
INGRESS_TLS_SECRET_NAME="argocd-secret"
CERT_MANAGER_CLUSTER_ISSUER="letsencrypt-app-gw-staging"

clear && \
echo "" && \
echo "HTTPBIN_HOST................: ${HTTPBIN_HOST?}" && \
echo "INGRESS_CLASS_NAME..........: ${INGRESS_CLASS_NAME?}" && \
echo "INGRESS_TLS_SECRET_NAME.....: ${INGRESS_TLS_SECRET_NAME?}" && \
echo "CERT_MANAGER_CLUSTER_ISSUER.: ${CERT_MANAGER_CLUSTER_ISSUER?}" && \
echo ""

helm upgrade \
  --install \
  --namespace argocd-infra \
  --create-namespace \
  httpbin httpbin/ \
  --set "ingress.enabled=true" \
  --set "ingress.className=${INGRESS_CLASS_NAME?}" \
  --set "ingress.annotations.certmanager\.k8s\.io/cluster-issuer=${CERT_MANAGER_CLUSTER_ISSUER?}" \
  --set "ingress.annotations.kubernetes\.io/tls-acme=\"true\"" \
  --set "ingress.hosts[0].host=${HTTPBIN_HOST?}" \
  --set "ingress.hosts[0].paths[0].path=/" \
  --set "ingress.hosts[0].paths[0].pathType=ImplementationSpecific" \
  --set "ingress.tls[0].secretName=${INGRESS_TLS_SECRET_NAME?}" \
  --set "ingress.tls[0].hosts[0]=${HTTPBIN_HOST?}"

kubectl get ingress -n httpbin
echo ""

dig ${HTTPBIN_HOST?} | grep -E "^${HTTPBIN_HOST?}"
echo ""

echo "curl http://${HTTPBIN_HOST}/get"
