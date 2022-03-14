#!/bin/bash

# Create an Environment with two Regions
env DEBUG=2 stackrun silviosilva/azure-wasp-foundation:0.1.0-wasp-sbx-na \
  apply -auto-approve

# Create AKS Cluster
env DEBUG=2 stackrun \
  silviosilva/azure-kubernetes-cluster:3.9.0-wasp-sbx-na-eus2-blue \
    apply -auto-approve

env DEBUG=0 stackrun \
  silviosilva/azure-kubernetes-cluster:3.9.0-wasp-sbx-na-eus2-blue \
    output \
      -raw kubeconfig > ${HOME}/.kube/config

chmod 0600 ${HOME}/.kube/config

# Install External Secrets
../install/external-secrets/install.sh

# Install NGINX Ingress Controller
../install/ingress-nginx/install.sh

# Install External DNS
../install/external-dns/install.sh

# Install cert-manager
../install/cert-manager/install.sh

# NGINX Ingress Controller Service Load Balancer
#                                     silvios.me parent zone
#                                wasp.silvios.me child zone
#                        sandbox.wasp.silvios.me child zone
#                eastus2.sandbox.wasp.silvios.me child zone
#              centralus.sandbox.wasp.silvios.me child zone
# argocd-green                                   CNAME
# argocd-blue                                    CNAME

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
../install/argocd/install.sh argocd-infra

# Retrieve ArgoCD Initial Password
../scripts/argocd_retrieve_initial_admin_password.sh
