#!/bin/bash
echo ""

SCRIPT_PATH="$(dirname $0)"

NAMESPACE=${1-argocd-infra}

ARGOCD_HELM_FILE_SERVICE="${HOME}/.helm/argocd/values.yaml"

mkdir -p "${HOME}/.helm/argocd/"

helm repo add argo https://argoproj.github.io/argo-helm

helm repo update argo

ARGOCD_APP_REGISTRATION_ID="${ARGOCD_APP_REGISTRATION_ID-5b59d3e0-04f4-4be4-aff4-b159a8ed4b46}"

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
  config:
    url: https://argocd.sandbox.wasp.silvios.me
    oidc.config: |
      name: AzureAD
      issuer: https://login.microsoftonline.com/${ARM_TENANT_ID}/v2.0
      clientID: ${ARGOCD_APP_REGISTRATION_ID}
      clientSecret: \$oidc.azuread.clientSecret
      requestedIDTokenClaims:
        groups:
          essential: true
      requestedScopes:
        - openid
        - profile
        - email
EOF

helm upgrade \
  --install \
  --namespace ${NAMESPACE?} \
  --create-namespace \
  argocd argo/argo-cd \
  --values "${ARGOCD_HELM_FILE_SERVICE?}" \
  --values "${SCRIPT_PATH}/extra-objects.yaml" \
  --wait
