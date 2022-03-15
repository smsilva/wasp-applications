#!/bin/bash
echo ""

SCRIPT_PATH="$(dirname $0)"

NAMESPACE=${1-ingress-nginx}

helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
echo ""

helm repo update ingress-nginx
echo ""

helm search repo ingress-nginx
echo ""

helm upgrade \
  --install \
  --namespace ${NAMESPACE?} \
  --create-namespace \
  --version "${INGRESS_NGINX_VERSION?}" \
  ingress-nginx ingress-nginx/ingress-nginx \
  --wait
