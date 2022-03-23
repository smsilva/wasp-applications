#!/bin/bash
set -e

export DIRECTORY_NAME="$(dirname ${0})"
export SCRIPTS_DIRECTORY="${PWD}/${DIRECTORY_NAME}/scripts"
export PATH=${PATH}:${SCRIPTS_DIRECTORY}

. load_parameters

show_parameters

# create_aks_cluster_with_application_gateway

# install_aad_pod_identity

# install_azure_gateway_ingress_controller

# install_external_secrets

# install_external_dns

# install_cert_manager

install_argocd

finish
