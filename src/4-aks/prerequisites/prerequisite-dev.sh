az account set --subscription 186d83fa-fddb-4637-a762-918a4cc06ee0

LOCATION=westeurope
RESOURCEGROUP_NETWORK=matrix-dev-network
RESOURCEGROUP_DATA=matrix-dev-data
RESOURCEGROUP_K8S=matrix-dev-k8s
RESOURCEGROUP_KEYVAULT=matrix-dev-keyvault
RESOURCEGROUP_COMMON=matrix-common

SPN_REGISTRY_NAME=spn-matrix-registry
SPN_DEPLOY_NAME=spn-matrix-dev-deployment
SPN_AKS_NAME=spn-matrix-dev-k8s

KEYVAULT_NAME=matrix-secrets-dev #Make sure this is a unique name
REGISTRY_NAME=matriximages  #Make sure this is a unique name
IDENTITY_AKSKEYVAULT_NAME=identity-kv-aks-dev

. ./prerequisite.sh