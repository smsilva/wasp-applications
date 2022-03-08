#/bin/bash
export VALUES_FILE="infrastructure/bootstrap/app-of-apps/values-wasp-dev-eastus2.yaml"
export ARGOCD_NAMESPACE="argocd-infra"

# Create a Local Kind Cluster 
kustomize/kind/create-cluster.sh

# Install ArgoCD
install/argocd/install.sh ${ARGOCD_NAMESPACE?}

# Create an ArgoCD Application
./create-argocd-apps-of-apps.sh ${ARGOCD_NAMESPACE?} "${VALUES_FILE?}"

# Retrieve ArgoCD Information
./scripts/argocd_retrieve_initial_admin_password.sh ${ARGOCD_NAMESPACE?}
