## 0.4.0 (2022-03-13)

### Refactor

- **pipelines/common/steps/install-terraform-packager.yaml**: Step terraform-packager rename Display Name
- **pipelines**: Provision Environment with Parameter
- **common/steps/**: Update steps displayName
- **common/steps/**: Update steps displayName
- **pipelines**: Refactor to extract common/steps/install-argocd.yaml
- **httpbin/raw**: Remove Directory

### Fix

- **pipelines/common/steps/provision-kubernetes-cluster.yaml**: Add -auto-approve to apply
- **pipelines/common/steps/provision-kubernetes-cluster.yaml**: Remove environment parameter reference
- **pipelines/foundation.yaml**: AKS Get Credentials

### Feat

- **pipelines/common/steps/provision***: Refactor to use apply again
- **foundation/aks-cluster/docker/Dockerfile.template**: Set STACK_INSTANCE_NAME as immutable
- **pipelines**: Refactor to extract common/steps/provision-environment.yaml
- **pipelines**: Refactor to extract common/steps/install-external-dns.yaml
- **pipelines**: Refactor to extract common/steps/install-kubernetes-cluster.yaml
- **pipelines**: Refactor to extract common/steps/install-nginx-ingress-controller.yaml
- **pipelines**: Refactor to extract common/steps/install-kubectl.yaml
- **pipelines**: Refactor to extract common/steps/install-argocd.yaml
- **pipelines**: Refactor to extract common/steps/install-httpbin.yaml
- **pipelines**: Refactor to extract common/steps/install-helm.yaml
- **pipelines**: Refactor to extract common/steps/install-terraform-packager.yaml
- **pipelines/foundation.yaml**: Install ArgoCD
- **pipelines/foundation.yaml**: Install httpbin Helm Chart
- **pipelines/foundation.yaml**: Install ExternalDNS
- **pipelines/foundation.yaml**: Install NGINX Ingress Controller
- **pipelines**: Update Foundation Pipeline
- **pipelines**: Foundation
- **run.sh**: External DNS commands
- **charts**: Add httpbin Helm Chart with Ingress
- **foundation/**: Add an AKS Cluster
- **foundation/**: Create directory with scripts to generate an new environment
- **install/**: ArgoCD Install using Helm
- **root**: Customize ArgoCD Namespace
- **infrastructure/**: Rename values files and update parameters
- **infrastructure/argocd-application.yaml**: Remove file

## 0.3.0 (2022-03-06)

### Feat

- **infrastructure/**: Install istio-gateway on Kind Cluster
- **infrastructure/**: Install istio on kind cluster
- **infrastructure/**: Create cert-manager Helm Chart
- **kustomize/example/helm-example/**: Remove helm-example Helm Chart
- **infrastructure/**: Split infra ArgoCD Project from app-of-apps Helm Chart
- **infrastructure/**: New app-of-apps Application
- **infrastructure/**: Add Global Helm Parameters to ArgoCD Applications
- **kustomize/example/helm-example**: Add a Helm Chart
- **kustomize/**: Add a kustomize directory
- **infrastructure/applications/values.yaml**: Add argocd-config Helm Chart
- **infrastructure/**: Add new metrics-server Helm Chart
- **infrastructure/charts/**: Add a ingress-nginx Helm Chart
- **infrastructure/**: Create crossplane-base and crossplane-providers Helm Charts
- **infrastructure/applications/values.yaml**: Adding crossplane Helm Chart to the Cluster
- **infrastructure/charts/crossplane/**: Update Helm Chart with Crossplane Resources
- **infrastructure/argocd-project.yaml**: Add namespaceResourceWhitelist and clusterResourceWhitelist
- **infrastructure/charts/external-secrets/**: Add new external-secrets Helm Chart
- **infrastructure/**: Create infra ArgoCd Project

### Refactor

- **infrastructure/charts/**: Rename istio to istio-istiod Helm Chart
- **infrastructure/bootstrap/app-of-apps/**: Rename files and update values
- **scripts**: Rename values and scripts

## 0.1.0 (2022-03-05)

### Feat

- **root**: Init Conventional Commits
- **infrastructure/applications/templates/application.yaml**: ignore differences for CRDs and ValidatingWebhookConfiguration
- **infrastructure/charts/**: Add istiod
- **infrastructure/**: New namespaces Application

### Refactor

- **infrastructure/argocd-application.yaml**: move path parameter up

### Fix

- **infrastructure/**: Use namespace from Application
