# wasp-gitops

## Overview

This repository contains the source code for the WASP GitOps project. The project is a collection of tools and utilities that can be used to manage the GitOps lifecycle of a Kubernetes cluster.

## Istio Charts update

The Istio charts are updated using the following command:

```bash
./update-istio-charts.sh
```

## New Relic Charts update

The New Relic charts are updated using the following command:

```bash
helm repo add newrelic https://helm-charts.newrelic.com

helm repo update newrelic

helm fetch newrelic/nri-bundle \
  --untar \
  --destination infrastructure/charts/

```