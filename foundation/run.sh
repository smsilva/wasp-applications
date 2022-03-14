#!/bin/bash

# NGINX Ingress Controller Service Load Balancer
#                                     silvios.me PARENT_ZONE
#                                wasp.silvios.me CHILD_ZONE
#                        sandbox.wasp.silvios.me CHILD_ZONE
#                eastus2.sandbox.wasp.silvios.me CHILD_ZONE
#              centralus.sandbox.wasp.silvios.me CHILD_ZONE
# argocd-blue                                    CNAME
# argocd-green                                   CNAME

# Create an Environment with two Regions
env DEBUG=2 stackrun silviosilva/azure-wasp-foundation:0.1.0-wasp-sbx-na \
  apply -auto-approve

# Create AKS Cluster
AKS_IMAGE="silviosilva/azure-kubernetes-cluster:3.10.0-wasp-sbx-na-eus2-blue"

env DEBUG=2 stackrun \
  ${AKS_IMAGE} \
    apply -auto-approve

env DEBUG=0 stackrun \
  ${AKS_IMAGE} \
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

# Deploy httpbin with Ingress:
#   - httpbin.eastus2.sandbox.wasp.silvios.me
../install/httpbin/install.sh

# Install ArgoCD using Helm Chart
#   - argocd-green.eastus2.sandbox.wasp.silvios.me
../install/argocd/install.sh argocd-infra

# Retrieve ArgoCD Initial Password
../scripts/argocd_retrieve_initial_admin_password.sh
