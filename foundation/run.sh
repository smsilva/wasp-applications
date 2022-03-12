#!/bin/bash

export DEBUG=1
export ENVIRONMENT_NAME="wasp-sbx-na"
export NAMESPACE="argocd-infra"

# Create Azure Key Vaults for each region
environment/create.sh

# Create AKS Cluster
env DEBUG=2 stackrun silviosilva/azure-kubernetes-cluster:3.9.0-wasp-sbx-eus2-blue apply -auto-approve
env DEBUG=0 stackrun silviosilva/azure-kubernetes-cluster:3.9.0-wasp-sbx-eus2-blue output -raw kubeconfig > ${HOME}/.kube/config

chmod 0600 ${HOME}/.kube/config

# Install NGINX Ingress Controller
../install/ingress-nginx/install.sh

# Install External DNS
../install/external-dns/install.sh

# NGINX Ingress Controller Service Load Balancer
#                     silvios.me parent zone
#                wasp.silvios.me child zone
#        sandbox.wasp.silvios.me child zone
# argocd.sandbox.wasp.silvios.me CNAME
#    app.sandbox.wasp.silvios.me CNAME

# Deploy httpbin with Ingress
helm upgrade \
  --install \
  --namespace httpbin \
  --create-namespace \
  httpbin ../install/httpbin \
  --set "ingress.enabled=true" \
  --set "ingress.hosts[0].host=echo.sandbox.wasp.silvios.me" \
  --set "ingress.hosts[0].paths[0].path=/" \
  --set "ingress.hosts[0].paths[0].pathType=ImplementationSpecific" \
  --wait

# Install ArgoCD using Helm Chart
../install/argocd/install.sh ${NAMESPACE?}

# Retrieve ArgoCD Initial Password
../scripts/argocd_retrieve_initial_admin_password.sh
