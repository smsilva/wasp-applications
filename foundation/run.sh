#!/bin/bash
SCRIPT_PATH="$(dirname $0)"

source "${SCRIPT_PATH}/parameters.conf"

# NGINX Ingress Controller Service Load Balancer
#                                     silvios.me PARENT_ZONE
#                                wasp.silvios.me CHILD_ZONE
#                        sandbox.wasp.silvios.me CHILD_ZONE
#                eastus2.sandbox.wasp.silvios.me CHILD_ZONE
#              centralus.sandbox.wasp.silvios.me CHILD_ZONE
# argocd-blue                                    CNAME
# argocd-green                                   CNAME

${SCRIPT_PATH}/show_parameters

# Create an Environment with two Regions
env DEBUG=1 stackrun ${ENVIRONMENT_IMAGE?} \
  apply -auto-approve

# Create AKS Cluster
env DEBUG=1 stackrun \
  ${KUBERNETES_CLUSTER_IMAGE?} \
    apply -auto-approve

env DEBUG=0 stackrun \
  ${KUBERNETES_CLUSTER_IMAGE?} \
    output \
      -raw kubeconfig > ${HOME}/.kube/config

chmod 0600 ${HOME}/.kube/config

# Install External Secrets
${SCRIPT_PATH}/../install/external-secrets/install.sh

# Install NGINX Ingress Controller
${SCRIPT_PATH}/../install/ingress-nginx/install.sh

# Install External DNS
${SCRIPT_PATH}/../install/external-dns/install.sh

# Install cert-manager
${SCRIPT_PATH}/../install/cert-manager/install.sh

# Deploy httpbin with Ingress:
#   - httpbin.eastus2.sandbox.wasp.silvios.me
${SCRIPT_PATH}/../install/httpbin/install.sh

# Install ArgoCD using Helm Chart
#   - argocd-green.eastus2.sandbox.wasp.silvios.me
${SCRIPT_PATH}/../install/argocd/install.sh
