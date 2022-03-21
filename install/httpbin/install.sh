#!/bin/bash
echo ""

SCRIPT_PATH="$(dirname $0)"

# HTTPBIN_HOST="echo.eastus2.sandbox.wasp.silvios.me"
# INGRESS_CLASS_NAME="nginx"
HTTPBIN_HOST="wasp-sbx-na-eus2-blue.eastus2.cloudapp.azure.com"
INGRESS_CLASS_NAME="azure-application-gateway"
INGRESS_TLS_SECRET_NAME="httpbin-tls-ingress"
CERT_MANAGER_CLUSTER_ISSUER="letsencrypt-staging-application-gateway"

clear && \
echo "" && \
echo "HTTPBIN_HOST................: ${HTTPBIN_HOST?}" && \
echo "INGRESS_CLASS_NAME..........: ${INGRESS_CLASS_NAME?}" && \
echo "INGRESS_TLS_SECRET_NAME.....: ${INGRESS_TLS_SECRET_NAME?}" && \
echo "CERT_MANAGER_CLUSTER_ISSUER.: ${CERT_MANAGER_CLUSTER_ISSUER?}" && \
echo ""

helm upgrade \
  --install \
  --namespace httpbin \
  --create-namespace \
  httpbin ./charts/httpbin/ \
  --set "ingress.enabled=true" \
  --set "ingress.className=${INGRESS_CLASS_NAME?}" \
  --set "ingress.hosts[0].host=${HTTPBIN_HOST?}" \
  --set "ingress.hosts[0].paths[0].path=/" \
  --set "ingress.hosts[0].paths[0].pathType=ImplementationSpecific"

curl -I http://${HTTPBIN_HOST?}/get

helm upgrade \
  --install \
  --namespace httpbin \
  --create-namespace \
  httpbin ./charts/httpbin/ \
  --set "ingress.enabled=true" \
  --set "ingress.className=${INGRESS_CLASS_NAME?}" \
  --set "ingress.annotations.cert-manager\.io/cluster-issuer=${CERT_MANAGER_CLUSTER_ISSUER?}" \
  --set "ingress.hosts[0].host=${HTTPBIN_HOST?}" \
  --set "ingress.hosts[0].paths[0].path=/" \
  --set "ingress.hosts[0].paths[0].pathType=ImplementationSpecific" \
  --set "ingress.tls[0].secretName=${INGRESS_TLS_SECRET_NAME?}" \
  --set "ingress.tls[0].hosts[0]=${HTTPBIN_HOST?}"

kubectl -n httpbin get ingress
echo ""

dig ${HTTPBIN_HOST?} | grep -E "^${HTTPBIN_HOST?}"
echo ""

echo "curl http://${HTTPBIN_HOST}/get"

kubectl apply -f - <<EOF
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  labels:
    app.kubernetes.io/instance: httpbin
    app.kubernetes.io/name: httpbin
    app.kubernetes.io/version: 1.16.0
  annotations:
    cert-manager.io/cluster-issuer: ${CERT_MANAGER_CLUSTER_ISSUER?}
  name: httpbin
  namespace: httpbin
spec:
  ingressClassName: azure-application-gateway
  rules:
    - host: ${HTTPBIN_HOST?}
      http:
        paths:
        - path: /
          backend:
            service:
              name: httpbin
              port:
                number: 80
          pathType: ImplementationSpecific
  tls:
    - hosts:
        - ${HTTPBIN_HOST?}
      secretName: httpbin-tls-ingress-certificate
EOF
