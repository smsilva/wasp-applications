#!/bin/bash
echo ""

SCRIPT_PATH="$(dirname $0)"

NAMESPACE=${1-argocd-infra}

ARGOCD_HELM_FILE_SERVICE="${HOME}/.helm/argocd/values.yaml"

mkdir -p "${HOME}/.helm/argocd/"

helm repo add argo https://argoproj.github.io/argo-helm
echo ""

helm repo update argo
echo ""

helm search repo argo
echo ""

ARGOCD_APP_REGISTRATION_ID="${ARGOCD_APP_REGISTRATION_ID?}"
ARGOCD_HOST="${ARGOCD_HOST?}"
CERT_MANAGER_CLUSTER_ISSUER="${CERT_MANAGER_CLUSTER_ISSUER?}"

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
      cert-manager.io/cluster-issuer: ${CERT_MANAGER_CLUSTER_ISSUER}
    hosts:
      - ${ARGOCD_HOST}
    tls:
      - secretName: argocd-tls-certificate
        hosts:
          - ${ARGOCD_HOST}
  config:
    url: https://${ARGOCD_HOST}
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
  --version "${ARGOCD_VERSION?}" \
  --values "${ARGOCD_HELM_FILE_SERVICE?}" \
  --values "${SCRIPT_PATH}/extra-objects.yaml" \
  --wait

echo ""

kubectl ${NAMESPACE?} get ingress
echo ""

dig @8.8.8.8 ${ARGOCD_HOST?}
echo ""
