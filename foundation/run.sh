#!/bin/bash

export DEBUG=1
export ENVIRONMENT_NAME="wasp-sbx-na"
export NAMESPACE="argocd-infra"

# Create Azure Key Vaults on each region
environment/create.sh

# Create AKS Cluster
aks-cluster/create.sh "wasp-sbx-na-eus2-aks-a"

# Install NGINX Ingress Controller
../install/ingress-nginx/install.sh

# NGINX Ingress Controller Service Load Balancer
#                     silvios.me parent zone
#                wasp.silvios.me child zone
#        sandbox.wasp.silvios.me child zone
# argocd.sandbox.wasp.silvios.me CNAME         -> 20.94.97.111 (Load Balancer)
#    app.sandbox.wasp.silvios.me CNAME         -> 20.94.97.111 (Load Balancer)

# Deploy httpbin with Ingress
helm upgrade \
  --install \
  --namespace httpbin \
  --create-namespace \
  httpbin ../install/httpbin \
  --set "ingress.enabled=true" \
  --set "ingress.hosts[0].host=app.sandbox.wasp.silvios.me" \
  --set "ingress.hosts[0].paths[0].path=/" \
  --set "ingress.hosts[0].paths[0].pathType=ImplementationSpecific" \
  --wait

# Install ArgoCd using Helm Chart
../install/argocd/install.sh ${NAMESPACE?}

# Create ArgoCd infra Project
kubectl \
  apply \
  --namespace ${NAMESPACE?} \
  --filename ../infrastructure/project.yaml

helm upgrade \
  --install \
  --namespace ${NAMESPACE?} \
  app-of-apps-infra ../infrastructure/bootstrap/app-of-apps \
  --values "helm-variables/wasp-sbx-na-eus2-aks-a.yaml"

../scripts/argocd_retrieve_initial_admin_password.sh
