#/bin/bash
VALUES_FILE="infrastructure/bootstrap/app-of-apps/values-wasp-dev-na-eastus2.yaml"

# Create a Local Kind Cluster 
kustomize/kind/create-cluster.sh

# Install ArgoCD
kustomize/argocd/install.sh

# Create an ArgoCD Application
./create-argocd-apps-of-apps.sh "${VALUES_FILE?}"

# Retrieve ArgoCD Information
./scripts/argocd_retrieve_initial_admin_password.sh
