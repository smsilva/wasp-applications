#/bin/bash
NAMESPACE=${1-argocd-infra}
VALUES_FILE=${2}

kubectl \
  apply \
  --namespace ${NAMESPACE} \
  --filename infrastructure/project.yaml

helm install \
  app-of-apps-infra infrastructure/bootstrap/app-of-apps \
  --values "${VALUES_FILE?}"
