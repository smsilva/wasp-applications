#!/bin/bash
echo ""

SCRIPT_PATH="$(dirname $0)"

NAMESPACE=${1-argocd-infra}

ARGOCD_HELM_CHART_VERSION="3.35.2" # ArgoCD v2.2.5
ARGOCD_HELM_FILE_SERVICE="${HOME}/.helm/argocd/service.yaml"

mkdir -p "${HOME}/.helm/argocd/"

helm repo add argo https://argoproj.github.io/argo-helm

helm repo update argo

cat <<EOF > "${ARGOCD_HELM_FILE_SERVICE?}"
fullnameOverride: "argocd"
server:
  ingress:
    enabled: true
    ingressClassName: "nginx"
    annotations:
      nginx.ingress.kubernetes.io/force-ssl-redirect: "true"
      nginx.ingress.kubernetes.io/ssl-passthrough: "true"
      nginx.ingress.kubernetes.io/backend-protocol: "HTTPS"
    hosts:
      - argocd.sandbox.wasp.silvios.me
EOF

helm upgrade \
  --install \
  --namespace ${NAMESPACE?} \
  --create-namespace \
  --version ${ARGOCD_HELM_CHART_VERSION?} \
  argocd argo/argo-cd \
  --values "${ARGOCD_HELM_FILE_SERVICE?}"

for DEPLOYMENT_NAME in $(kubectl --namespace ${NAMESPACE?} get deploy -o name); do
  kubectl \
    --namespace ${NAMESPACE?} \
    wait \
    --for condition=Available \
    --timeout=360s \
    "${DEPLOYMENT_NAME?}";
done
