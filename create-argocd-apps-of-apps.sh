#/bin/bash
NAMESPACE=${1-argocd-infra}

kubectl \
  apply \
  --namespace ${NAMESPACE} \
  --filename infrastructure/project.yaml

VALUES_FILE=${1}

helm install app-of-apps-infra infrastructure/bootstrap/app-of-apps \
  --values "${VALUES_FILE?}"
