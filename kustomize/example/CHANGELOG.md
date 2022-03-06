## 0.2.0 (2022-03-06)

### Feat

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
