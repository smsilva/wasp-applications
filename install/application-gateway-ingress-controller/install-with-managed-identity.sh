#!/bin/bash
export WORK_DIRECTORY="${HOME}/trash"
export PARAMETERS_FILE="${WORK_DIRECTORY?}/parameters.json"
export TEMPLATE_FILE="${WORK_DIRECTORY?}/template.json"
export DEPLOYMENT_OUTPUTS_FILE="${WORK_DIRECTORY?}/deployment-outputs.json"
export HELM_CONFIG_FILE="${WORK_DIRECTORY?}/helm-config.yaml"

export AKS_NAME="wasp-sbx-na-eus2-blue"
export AKS_RESOURCE_GROUP_NAME="wasp-sbx-na-eus2-blue"
export AKS_INFORMATION_FILE="${WORK_DIRECTORY?}/${AKS_NAME?}.json"
export APP_GATEWAY_NAME="${AKS_NAME?}"
export APP_GATEWAY_RESOURCE_GROUP_NAME="${AKS_RESOURCE_GROUP_NAME?}"
export APP_GATEWAY_INFORMATION_FILE="${WORK_DIRECTORY?}/${APP_GATEWAY_NAME?}-app-gw.json"

az aks list -o table

az network application-gateway list -o table

# Brownfield Deployment
# https://github.com/Azure/application-gateway-kubernetes-ingress/blob/master/docs/setup/install-existing.md

# AAD Pod Identity - with RBAC
# https://github.com/Azure/application-gateway-kubernetes-ingress/blob/master/docs/setup/install-existing.md#set-up-aad-pod-identity
kubectl apply -f https://raw.githubusercontent.com/Azure/aad-pod-identity/v1.6.0/deploy/infra/deployment-rbac.yaml

# Retrieve AKS Information
az aks show \
  --name ${AKS_NAME?} \
  --resource-group ${AKS_RESOURCE_GROUP_NAME?} > "${AKS_INFORMATION_FILE?}" && echo "${AKS_INFORMATION_FILE?}"

az network application-gateway show \
  --name ${APP_GATEWAY_NAME?} \
  --resource-group ${APP_GATEWAY_RESOURCE_GROUP_NAME?} > "${APP_GATEWAY_INFORMATION_FILE?}" && echo "${APP_GATEWAY_INFORMATION_FILE?}"

nodeResourceGroup=$(jq -r '.nodeResourceGroup' "${AKS_INFORMATION_FILE?}")
identityClientId=$(jq -r '.identityProfile.kubeletidentity.clientId' "${AKS_INFORMATION_FILE?}")
identityObjectId=$(jq -r '.identityProfile.kubeletidentity.objectId' "${AKS_INFORMATION_FILE?}")
identityResourceId=$(jq -r '.identityProfile.kubeletidentity.resourceId' "${AKS_INFORMATION_FILE?}")

identityName=$(az identity show \
  --ids ${identityResourceId?} \
  --output tsv \
  --query "name")

appGatewayResourceId="$(jq -r '.id' "${APP_GATEWAY_INFORMATION_FILE?}")"

appGatewayResourceGroupId="$(az group show \
  --name ${APP_GATEWAY_RESOURCE_GROUP_NAME?} \
  --output tsv \
  --query id)"

echo "identityName..............: ${identityName}" && \
echo "identityClientId..........: ${identityClientId}" && \
echo "identityObjectId..........: ${identityObjectId}" && \
echo "identityResourceId........: ${identityResourceId}" && \
echo "appGatewayResourceId......: ${appGatewayResourceId}" && \
echo "appGatewayResourceGroupId.: ${appGatewayResourceGroupId}"

# Show Managed Identity Information
az identity show --ids ${identityResourceId?}

# Create a Contributor Role Assignment for Kubelet Managed Identity on Application Gateway
az role assignment create \
  --role "Contributor" \
  --assignee ${identityClientId?} \
  --scope "${appGatewayResourceId?}" # <App-Gateway-ID>

# Create a Reader Role Assignment for Kubelet Managed Identity on Application Gateway Resource Group 
az role assignment create \
  --role "Reader" \
  --assignee $identityClientId \
  --scope "${appGatewayResourceGroupId}" # <App-Gateway-Resource-Group-ID>

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

kubectl logs -f -l app=ingress-azure

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
