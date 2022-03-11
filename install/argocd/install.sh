#!/bin/bash
SCRIPT_PATH="$(dirname $0)"

NAMESPACE=${1-argocd-infra}

HELM_DIRECTORY="${HOME}/.helm/"
ARGOCD_HELM_CHART_VERSION="3.35.2" # ArgoCD v2.2.5
ARGOCD_HELM_FILE_SERVICE="${HOME}/.helm/argocd/service.yaml"

helm repo add argo https://argoproj.github.io/argo-helm

helm repo update argo

cat <<EOF > "${ARGOCD_HELM_FILE_SERVICE?}"
server:
  service:
    type: LoadBalancer
    annotations:
      service.beta.kubernetes.io/azure-dns-label-name: "wasp-sbx-na-eus2-aks-a"
EOF

helm upgrade \
  --install \
  --namespace ${NAMESPACE?} \
  --create-namespace \
  --version ${ARGOCD_HELM_CHART_VERSION?} \
  argocd argo/argo-cd \
  --set fullnameOverride='argocd'

for DEPLOYMENT_NAME in $(kubectl --namespace ${NAMESPACE?} get deploy -o name); do
  kubectl \
    --namespace ${NAMESPACE?} \
    wait \
    --for condition=Available \
    --timeout=360s \
    "${DEPLOYMENT_NAME?}";
done
