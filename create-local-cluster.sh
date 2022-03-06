#/bin/bash

REGION_NAME="wasp-dev-na-eastus2"

# Create a Local Kind Cluster 
kustomize/kind/create-cluster.sh

# Install ArgoCD
kustomize/argocd/install.sh

# Create an ArgoCD Application
./create-argocd-apps-of-apps.sh \
  "infrastructure/bootstrap/app-of-apps/values-${REGION_NAME?}.yaml"

# Retrieve ArgoCD Information
./scripts/argocd_retrieve_initial_admin_password.sh
