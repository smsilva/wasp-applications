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
