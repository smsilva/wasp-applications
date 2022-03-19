#!/bin/bash

export WORK_DIRECTORY="${HOME}/trash"
export AKS_CLUSTER_IMAGE="silviosilva/azure-kubernetes-with-appgw:4.3.0"
export AKS_INFORMATION_FILE="${WORK_DIRECTORY?}/cluster-outputs.json"

env \
  DEBUG=1 \
  stackrun ${AKS_CLUSTER_IMAGE?} apply -auto-approve

echo ""

env \
  DEBUG=0 \
  stackrun ${AKS_CLUSTER_IMAGE?} \
    output -raw kubeconfig > ~/.kube/config

chmod 0600 ~/.kube/config

kubectl get namespaces

# AAD Pod Identity - with RBAC
# https://github.com/Azure/application-gateway-kubernetes-ingress/blob/master/docs/setup/install-existing.md#set-up-aad-pod-identity
kubectl \
  apply \
  -f https://raw.githubusercontent.com/Azure/aad-pod-identity/v1.6.0/deploy/infra/deployment-rbac.yaml

echo ""

env \
  DEBUG=0 \
  stackrun ${AKS_CLUSTER_IMAGE?} output -json > "${AKS_INFORMATION_FILE?}"

export MANAGED_IDENTITY_ID="$(                    jq -r .kubelet_identity_id.value                     "${AKS_INFORMATION_FILE?}")"
export MANAGED_IDENTITY_CLIENT_ID="$(             jq -r .kubelet_identity_client_id.value              "${AKS_INFORMATION_FILE?}")"
export APPLICATION_GATEWAY_ID="$(                 jq -r .application_gateway_id.value                  "${AKS_INFORMATION_FILE?}")"
export APPLICATION_GATEWAY_NAME="$(               jq -r .application_gateway_name.value                "${AKS_INFORMATION_FILE?}")"
export APPLICATION_GATEWAY_RESOURCE_GROUP_NAME="$(jq -r .application_gateway_resource_group_name.value "${AKS_INFORMATION_FILE?}")"

clear && \
echo "" && \
echo "MANAGED_IDENTITY_ID.....................: ${MANAGED_IDENTITY_ID}" && \
echo "MANAGED_IDENTITY_CLIENT_ID..............: ${MANAGED_IDENTITY_CLIENT_ID}" && \
echo "APPLICATION_GATEWAY_ID..................: ${APPLICATION_GATEWAY_ID}" && \
echo "APPLICATION_GATEWAY_NAME................: ${APPLICATION_GATEWAY_NAME}" && \
echo "APPLICATION_GATEWAY_RESOURCE_GROUP_NAME.: ${APPLICATION_GATEWAY_RESOURCE_GROUP_NAME}" && \
echo ""

# Install Ingress Controller as a Helm Chart
# https://github.com/Azure/application-gateway-kubernetes-ingress/blob/master/docs/setup/install-existing.md#install-ingress-controller-as-a-helm-chart

helm repo add    application-gateway-kubernetes-ingress https://appgwingress.blob.core.windows.net/ingress-azure-helm-package/
helm repo update application-gateway-kubernetes-ingress
helm search repo application-gateway-kubernetes-ingress

clear && \
echo "" && \
echo "appgw.subscriptionId.......: ${ARM_SUBSCRIPTION_ID?}" && \
echo "appgw.resourceGroup........: ${APPLICATION_GATEWAY_RESOURCE_GROUP_NAME?}" && \
echo "appgw.name.................: ${APPLICATION_GATEWAY_NAME?}" && \
echo "armAuth.identityResourceID.: ${MANAGED_IDENTITY_ID?}" && \
echo "armAuth.identityClientID...: ${MANAGED_IDENTITY_CLIENT_ID?}" && \
echo ""

helm install ingress-azure \
  --set "appgw.subscriptionId=${ARM_SUBSCRIPTION_ID?}" \
  --set "appgw.resourceGroup=${APPLICATION_GATEWAY_RESOURCE_GROUP_NAME?}" \
  --set "appgw.name=${APPLICATION_GATEWAY_NAME?}" \
  --set "armAuth.type=aadPodIdentity" \
  --set "armAuth.identityResourceID=${MANAGED_IDENTITY_ID?}" \
  --set "armAuth.identityClientID=${MANAGED_IDENTITY_CLIENT_ID?}" \
  --set "rbac.enabled=true" \
  application-gateway-kubernetes-ingress/ingress-azure \
  --wait

echo ""

kubectl logs -f -l app=ingress-azure
echo ""

kubectl apply -f - <<EOF
apiVersion: v1
kind: Pod
metadata:
  name: aspnetapp
  labels:
    app: aspnetapp
spec:
  containers:
    - image: "mcr.microsoft.com/dotnet/core/samples:aspnetapp"
      name: aspnetapp-image
      ports:
        - containerPort: 80
          protocol: TCP
---
apiVersion: v1
kind: Service
metadata:
  name: aspnetapp
spec:
  selector:
    app: aspnetapp
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: aspnetapp
spec:
  ingressClassName: azure-application-gateway
  rules:
    - http:
        paths:
          - path: /
            backend:
              service:
                name: aspnetapp
                port:
                  number: 80
            pathType: Exact
EOF
echo ""

APPLICATION_INGRESS_PUBLIC_IP=""
while [ -z "${APPLICATION_INGRESS_PUBLIC_IP}" ]; do
  APPLICATION_INGRESS_PUBLIC_IP="$(kubectl get Ingress aspnetapp --template="{{range .status.loadBalancer.ingress}}{{.ip}}{{end}}")"
  echo "APPLICATION_INGRESS_PUBLIC_IP: ${APPLICATION_INGRESS_PUBLIC_IP}"
done
echo ""

kubectl describe ingress
echo ""

curl -Is ${APPLICATION_INGRESS_PUBLIC_IP}
echo ""
