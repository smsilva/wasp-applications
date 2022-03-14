#!/bin/bash
echo ""

SCRIPT_PATH="$(dirname $0)"

NAMESPACE=${1-ingress-nginx}

helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx

helm repo update ingress-nginx

helm upgrade \
  --install \
  --namespace ${NAMESPACE?} \
  --create-namespace \
  ingress-nginx ingress-nginx/ingress-nginx \
  --wait
