#!/bin/bash
SCRIPT_PATH="$(dirname $0)"

NAMESPACE=${1-argocd-infra}

kubectl create namespace ${NAMESPACE}

kubectl \
  apply \
  --namespace ${NAMESPACE} \
  --kustomize ${SCRIPT_PATH}/base

for DEPLOYMENT_NAME in $(kubectl --namespace ${NAMESPACE} get deploy -o name); do
  kubectl \
    --namespace ${NAMESPACE} \
    wait \
    --for condition=Available \
    --timeout=360s \
    "${DEPLOYMENT_NAME}";
done
