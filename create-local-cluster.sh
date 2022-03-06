#/bin/bash

# Create a Local Kind Cluster 
kustomize/kind/create-cluster.sh

# Install ArgoCD
kustomize/argocd/install.sh

# Create an ArgoCD Application
./create-argocd-apps-of-apps.sh \
  infrastructure/bootstrap/app-of-apps/values-wasp-dev-na-north.yaml

# Retrieve ArgoCD Information
./scripts/argocd_retrieve_initial_admin_password.sh
