#/bin/bash
kubectl apply --filename infrastructure/project.yaml

VALUES_FILE=${1}

helm install app-of-apps-infra infrastructure/bootstrap/app-of-apps \
  --values "${VALUES_FILE?}"
