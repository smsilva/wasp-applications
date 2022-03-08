#/bin/bash

# Create a Local Kind Cluster 
kustomize/kind/create-cluster.sh

# Install ArgoCD
ARGOCD_NAMESPACE="argocd-infra"
kustomize/argocd/install.sh "${ARGOCD_NAMESPACE?}"

# Create an ArgoCD Application
VALUES_FILE="infrastructure/bootstrap/app-of-apps/values-wasp-dev-eastus2.yaml"
./create-argocd-apps-of-apps.sh "${VALUES_FILE?}"

# Retrieve ArgoCD Information
./scripts/argocd_retrieve_initial_admin_password.sh "${ARGOCD_NAMESPACE?}"
