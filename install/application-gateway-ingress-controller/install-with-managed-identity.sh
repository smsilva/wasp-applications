#!/bin/bash
export PARAMETERS_FILE="${WORK_DIRECTORY?}/parameters.json"
export TEMPLATE_FILE="${WORK_DIRECTORY}/template.json"
export DEPLOYMENT_OUTPUTS_FILE="${WORK_DIRECTORY}/deployment-outputs.json"
export HELM_CONFIG_FILE="${WORK_DIRECTORY}/helm-config.yaml"

export WORK_DIRECTORY="${HOME}/trash"
export AKS_NAME="wasp-sbx-na-eus2-blue"
export AKS_RESOURCE_GROUP_NAME="wasp-sbx-na-eus2-blue"
export AKS_INFORMATION_FILE="${WORK_DIRECTORY?}/${AKS_NAME?}.json"

# Brownfield Deployment

# https://github.com/Azure/application-gateway-kubernetes-ingress/blob/master/docs/setup/install-existing.md

# https://github.com/Azure/application-gateway-kubernetes-ingress/blob/master/docs/setup/install-existing.md#set-up-aad-pod-identity

kubectl apply -f https://raw.githubusercontent.com/Azure/aad-pod-identity/v1.6.0/deploy/infra/deployment-rbac.yaml

# Retrieve AKS Information
az aks show \
  --name ${AKS_NAME?} \
  --resource-group ${AKS_RESOURCE_GROUP_NAME?} > "${AKS_INFORMATION_FILE?}"

nodeResourceGroup=$(jq -r '.nodeResourceGroup' "${AKS_INFORMATION_FILE?}")

identityClientId=$(jq -r '.identityProfile.kubeletidentity.clientId' "${AKS_INFORMATION_FILE?}")
identityObjectId=$(jq -r '.identityProfile.kubeletidentity.objectId' "${AKS_INFORMATION_FILE?}")
identityResourceId=$(jq -r '.identityProfile.kubeletidentity.resourceId' "${AKS_INFORMATION_FILE?}")

identityName=$(az identity show \
  --ids ${identityResourceId?} \
  --output tsv \
  --query "name")

appGatewayResourceId="$(az network application-gateway show \
  --name wasp-sbx-na-eus2-blue \
  --resource-group wasp-sbx-na-eus2-blue \
  --query id \
  --output tsv)"

echo "nodeResourceGroup....: ${nodeResourceGroup}" && \
echo "appGatewayResourceId.: ${appGatewayResourceId}" && \
echo "identityName.........: ${identityName}" && \
echo "identityClientId.....: ${identityClientId}" && \
echo "identityObjectId.....: ${identityObjectId}" && \
echo "identityResourceId...: ${identityResourceId}"

az role assignment create \
  --role "Contributor" \
  --assignee ${identityClientId?} \
  --scope "${appGatewayResourceId?}"

az role assignment create \
  --role "Reader" \
  --assignee $identityClientId \
  --scope "$(az group show \
    --name ${AKS_RESOURCE_GROUP_NAME?} \
    --output tsv \
    --query id)" # <App-Gateway-Resource-Group-ID>

# Install Ingress Controller as a Helm Chart
# https://github.com/Azure/application-gateway-kubernetes-ingress/blob/master/docs/setup/install-existing.md#install-ingress-controller-as-a-helm-chart

helm repo add    application-gateway-kubernetes-ingress https://appgwingress.blob.core.windows.net/ingress-azure-helm-package/
helm repo update application-gateway-kubernetes-ingress
helm search repo application-gateway-kubernetes-ingress

wget https://raw.githubusercontent.com/Azure/application-gateway-kubernetes-ingress/master/docs/examples/sample-helm-config.yaml -O "${HELM_CONFIG_FILE?}"

code "${HELM_CONFIG_FILE?}"

helm install ingress-azure \
  --values "${HELM_CONFIG_FILE?}" \
  application-gateway-kubernetes-ingress/ingress-azure \
  --version 1.5.1

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

kubectl logs -f -l app=ingress-azure
