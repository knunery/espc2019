#!/bin/bash

LOCATION=westeurope
RESOURCEGROUP_NETWORK=matrix-dev-network
RESOURCEGROUP_K8S=matrix-dev-k8s
RESOURCEGROUP_KEYVAULT=matrix-dev-keyvault
RESOURCEGROUP_COMMON=matrix-common
DOMAIN_NAME=projectrome.cf
VNET_NAME=matrix-aks-vnet
WORKSPACE_NAME=matrix-ws-dev-rome # Must be a unique name
WORKSPACE_ARMTEMPLATE_PATH="../arm/resources/Microsoft.OperationalInsights/deploy.json"
AKS_NAME=matrix-aks-dev
AKS_NODE_COUNT=2
AKS_VM_SIZE=Standard_DS2_v2
IPADDRESS_NAME=matrix-aks-ip
TRAFFICMANAGER_NAME=matrix-tfmgr-dev # Must be a unique name
KEYVAULT_NAME=matrix-secrets-dev

clear
. provisioning.sh

