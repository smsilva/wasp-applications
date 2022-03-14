#!/bin/bash
echo ""

SCRIPT_PATH="$(dirname $0)"

HTTPBIN_HOST="echo.eastus2.sandbox.wasp.silvios.me"

helm upgrade \
  --install \
  --namespace httpbin \
  --create-namespace \
  httpbin ${SCRIPT_PATH}/httpbin \
  --set "ingress.enabled=true" \
  --set "ingress.hosts[0].host=${HTTPBIN_HOST?}" \
  --set "ingress.hosts[0].paths[0].path=/" \
  --set "ingress.hosts[0].paths[0].pathType=ImplementationSpecific" \
  --wait

kubectl get ingress -n httpbin

echo ""

dig ${HTTPBIN_HOST?} | grep -E "^${HTTPBIN_HOST?}"

echo ""

echo "curl http://${HTTPBIN_HOST}/get"
