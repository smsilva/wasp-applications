#!/bin/bash
SCRIPT_PATH="$(dirname $0)"

NAMESPACE=${1-argocd-infra}

ARGOCD_HELM_CHART_VERSION="3.35.2" # ArgoCD v2.2.5

helm repo add argo https://argoproj.github.io/argo-helm

helm repo update argo

helm upgrade \
  --install \
  --namespace ${ARGOCD_NAMESPACE?} \
  --create-namespace \
  --version ${ARGOCD_HELM_CHART_VERSION} \
  argocd argo/argo-cd \
  --set fullnameOverride='argocd' \
  --wait

for DEPLOYMENT_NAME in $(kubectl --namespace ${NAMESPACE} get deploy -o name); do
  kubectl \
    --namespace ${NAMESPACE} \
    wait \
    --for condition=Available \
    --timeout=360s \
    "${DEPLOYMENT_NAME}";
done
