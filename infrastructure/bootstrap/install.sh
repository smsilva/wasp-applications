#/bin/bash

ENVIRONMENT_ID="wasp.uat.na.silvios.me"
ENVIRONMENT_DOMAIN="wasp-uat-na-north-1"

helm install bootstrap app-of-apps \
  --dry-run \
  --set "global.environment.domain=${ENVIRONMENT_DOMAIN}" \
  --set "global.environment.id=${ENVIRONMENT_ID}"
