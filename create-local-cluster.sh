#/bin/bash
kustomize/kind/create-cluster.sh
kustomize/argocd/install.sh

./create-argocd-apps-of-apps.sh \
  infrastructure/bootstrap/app-of-apps/values-wasp-dev-na-north-1.yaml

./scripts/argocd_retrieve_initial_admin_password.sh
