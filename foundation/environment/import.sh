#!/bin/bash

export STACK_INSTANCE_NAME=${ENVIRONMENT_NAME}

stackrun silviosilva/azure-wasp-foundation:0.1.0 import -var="name=${ENVIRONMENT_NAME}" \
  '"module.regions[\"ceus\"].module.vault.azurerm_key_vault_access_policy.administrator[\"354788e6-9ed2-4338-9d62-67c3a8f5ca12\"]"' \
  '"/subscriptions/636a465c-d6b1-4533-b071-64cea37a2bf6/resourceGroups/wasp-sbx-na-ceus/providers/Microsoft.KeyVault/vaults/wasp-sbx-na-ceus/objectId/354788e6-9ed2-4338-9d62-67c3a8f5ca12"'

stackrun silviosilva/azure-wasp-foundation:0.1.0 import -var="name=${ENVIRONMENT_NAME}" \
  '"module.regions[\"ceus\"].module.vault.azurerm_key_vault_access_policy.administrator[\"805a3d92-4178-4ad1-a0d6-70eae41a463a\"]"' \
  '"/subscriptions/636a465c-d6b1-4533-b071-64cea37a2bf6/resourceGroups/wasp-sbx-na-ceus/providers/Microsoft.KeyVault/vaults/wasp-sbx-na-ceus/objectId/805a3d92-4178-4ad1-a0d6-70eae41a463a"'

stackrun silviosilva/azure-wasp-foundation:0.1.0 import -var="name=${ENVIRONMENT_NAME}" \
  '"module.regions[\"eus2\"].module.vault.azurerm_key_vault_access_policy.administrator[\"354788e6-9ed2-4338-9d62-67c3a8f5ca12\"]"' \
  '"/subscriptions/636a465c-d6b1-4533-b071-64cea37a2bf6/resourceGroups/wasp-sbx-na-eus2/providers/Microsoft.KeyVault/vaults/wasp-sbx-na-eus2/objectId/354788e6-9ed2-4338-9d62-67c3a8f5ca12"'

stackrun silviosilva/azure-wasp-foundation:0.1.0 import -var="name=${ENVIRONMENT_NAME}" \
  '"module.regions[\"eus2\"].module.vault.azurerm_key_vault_access_policy.administrator[\"805a3d92-4178-4ad1-a0d6-70eae41a463a\"]"' \
  '"/subscriptions/636a465c-d6b1-4533-b071-64cea37a2bf6/resourceGroups/wasp-sbx-na-eus2/providers/Microsoft.KeyVault/vaults/wasp-sbx-na-eus2/objectId/805a3d92-4178-4ad1-a0d6-70eae41a463a"'

stackrun silviosilva/azure-wasp-foundation:0.1.0 import -var="name=${ENVIRONMENT_NAME}" \
  'module.instance.module.vault.azurerm_key_vault_access_policy.administrator[\"805a3d92-4178-4ad1-a0d6-70eae41a463a\"]' \
  '"/subscriptions/636a465c-d6b1-4533-b071-64cea37a2bf6/resourceGroups/wasp-sbx-na/providers/Microsoft.KeyVault/vaults/wasp-sbx-na/objectId/805a3d92-4178-4ad1-a0d6-70eae41a463a"'

stackrun silviosilva/azure-wasp-foundation:0.1.0 import -var="name=${ENVIRONMENT_NAME}" \
  'module.instance.module.vault.azurerm_key_vault_access_policy.administrator[\"354788e6-9ed2-4338-9d62-67c3a8f5ca12\"]' \
  '"/subscriptions/636a465c-d6b1-4533-b071-64cea37a2bf6/resourceGroups/wasp-sbx-na/providers/Microsoft.KeyVault/vaults/wasp-sbx-na/objectId/354788e6-9ed2-4338-9d62-67c3a8f5ca12"'
