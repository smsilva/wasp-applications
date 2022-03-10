#!/bin/bash

export DEBUG=1
export ENVIRONMENT_NAME="wasp-sbx-na"
export NAMESPACE="argocd-infra"

# Create Azure Key Vaults on each region
environment/create.sh

# Create AKS Cluster
aks-cluster/create.sh "wasp-sbx-na-eus2-aks-a"

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
