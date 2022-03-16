#!/bin/bash
export WORK_DIRECTORY="${HOME}/trash"
export PARAMETERS_FILE="${WORK_DIRECTORY?}/parameters.json"
export TEMPLATE_FILE="${WORK_DIRECTORY}/template.json"
export DEPLOYMENT_OUTPUTS_FILE="${WORK_DIRECTORY}/deployment-outputs.json"
export HELM_CONFIG_FILE="${WORK_DIRECTORY}/helm-config.yaml"

# Greenfield Deployment
# https://github.com/Azure/application-gateway-kubernetes-ingress/blob/master/docs/setup/install-new.md

objectId=$(az ad sp show --id ${ARM_CLIENT_ID?} --query "objectId" -o tsv)

cat <<EOF > "${PARAMETERS_FILE?}"
{
  "aksServicePrincipalAppId": { "value": "${ARM_CLIENT_ID}" },
  "aksServicePrincipalClientSecret": { "value": "${ARM_CLIENT_SECRET}" },
  "aksServicePrincipalObjectId": { "value": "$objectId" },
  "aksEnableRBAC": { "value": true }
}
EOF

# Download the ARM template into template.json file. Paste the following in your shell
wget https://raw.githubusercontent.com/Azure/application-gateway-kubernetes-ingress/master/deploy/azuredeploy.json -O "${TEMPLATE_FILE?}"

resourceGroupName="MyResourceGroup"
location="eastus2"
deploymentName="ingress-appgw"

az group create \
  -n $resourceGroupName \
  -l $location

az group deployment create \
  -g $resourceGroupName \
  -n $deploymentName \
  --template-file "${TEMPLATE_FILE?}" \
  --parameters "${PARAMETERS_FILE?}"

az group deployment show \
  -g $resourceGroupName \
  -n $deploymentName \
  --query "properties.outputs" \
  -o json > "${DEPLOYMENT_OUTPUTS_FILE?}"

# use the deployment-outputs.json created after deployment to get the cluster name and resource group name
aksClusterName=$(jq -r ".aksClusterName.value" ${DEPLOYMENT_OUTPUTS_FILE?})
resourceGroupName=$(jq -r ".resourceGroupName.value" ${DEPLOYMENT_OUTPUTS_FILE?})

az aks get-credentials \
  --resource-group $resourceGroupName \
  --name $aksClusterName

kubectl apply -f https://raw.githubusercontent.com/Azure/aad-pod-identity/v1.8.6/deploy/infra/deployment-rbac.yaml

helm repo add application-gateway-kubernetes-ingress https://appgwingress.blob.core.windows.net/ingress-azure-helm-package/
helm repo update

applicationGatewayName=$(jq -r ".applicationGatewayName.value" ${DEPLOYMENT_OUTPUTS_FILE?})
resourceGroupName=$(jq -r ".resourceGroupName.value" ${DEPLOYMENT_OUTPUTS_FILE?})
subscriptionId=$(jq -r ".subscriptionId.value" ${DEPLOYMENT_OUTPUTS_FILE?})
identityClientId=$(jq -r ".identityClientId.value" ${DEPLOYMENT_OUTPUTS_FILE?})
identityResourceId=$(jq -r ".identityResourceId.value" ${DEPLOYMENT_OUTPUTS_FILE?})

wget https://raw.githubusercontent.com/Azure/application-gateway-kubernetes-ingress/master/docs/examples/sample-helm-config.yaml -O "${HELM_CONFIG_FILE?}"

sed -i "s|<subscriptionId>|${subscriptionId}|g" "${HELM_CONFIG_FILE?}"
sed -i "s|<resourceGroupName>|${resourceGroupName}|g" "${HELM_CONFIG_FILE?}"
sed -i "s|<applicationGatewayName>|${applicationGatewayName}|g" "${HELM_CONFIG_FILE?}"
sed -i "s|<identityResourceId>|${identityResourceId}|g" "${HELM_CONFIG_FILE?}"
sed -i "s|<identityClientId>|${identityClientId}|g" "${HELM_CONFIG_FILE?}"

# You can further modify the helm config to enable/disable features
code "${HELM_CONFIG_FILE?}"

az identity show --ids ${identityResourceId}

helm install ingress-azure \
  -f "${HELM_CONFIG_FILE?}" \
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
  annotations:
    kubernetes.io/ingress.class: azure/application-gateway
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

# helm upgrade \
#   --install \
#   ingress-azure \
#     application-gateway-kubernetes-ingress/ingress-azure \
#   --version "1.5.1" \
#   --set "appgw.subscriptionId=${ARM_SUBSCRIPTION_ID?}" \
#   --set "appgw.resourceGroup=${APPLICATION_GATEWAY_NAME?}" \
#   --set "appgw.name=${APPLICATION_GATEWAY_RESOURCE_GROUP_NAME?}" \
#   --set "rbac.enabled=true"

kubectl logs -f -l app=ingress-azure
