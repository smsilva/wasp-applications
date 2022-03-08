#!/bin/bash
NAMESPACE=${1-argocd-infra}

ARGOCD_INITIAL_PASSWORD=$(kubectl \
  --namespace ${NAMESPACE} \
  get secret argocd-initial-admin-secret \
  --output jsonpath="{.data.password}" | base64 -d)

LOCAL_ARGOCD_INITIAL_PASSWORD_FILE="${HOME}/.argocd-password.txt"

echo "${ARGOCD_INITIAL_PASSWORD}" > "${LOCAL_ARGOCD_INITIAL_PASSWORD_FILE}"

(
echo ""
echo "  1. Open a new Terminal and run a port-forward command:"
echo ""
echo "     kubectl --namespace ${NAMESPACE} port-forward svc/argocd-server 8443:443"
echo ""
echo "  2. Copy the Password for admin user:"
echo ""
echo "     ${LOCAL_ARGOCD_INITIAL_PASSWORD_FILE}:"
echo ""
echo "     ${ARGOCD_INITIAL_PASSWORD}"
echo ""
echo "  3. Open the addres bellow in a browser:"
echo ""
echo "     https://localhost:8443"
echo ""
echo "  4. (Optional) Add the line below to your /etc/hosts file:"
echo ""
echo "     127.0.0.1 argocd.example.com"
echo ""
echo "  4.1. Access ArgoCD:"
echo ""
echo "     https://argocd.example.com"
echo ""
)
