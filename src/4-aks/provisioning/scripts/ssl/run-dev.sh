DOMAINNAME=dev-ignitetour.cf
EMAILADDRESS=pnaber@xpirit.com
RENEW_THRESHOLD=60
CERTIFICATE_PATH=matrix-ssl-certificate.pfx
KEYVAULT_CERTIFICATE_NAME=matrix-ssl-certificate
KEYVAULT_NAME=matrix-secrets-dev
export RESOURCEGROUP_DNSZONE=matrix-dev-network

export LETSENCRYPT_CONFIGDIR=letsencrypt
# FOR WSL
# CERT_DIR=$LETSENCRYPT_CONFIGDIR/archive
# PEM_FILE=cert1.pem
# PEM_KEY=privkey1.pem
# For Linux
CERT_DIR=$LETSENCRYPT_CONFIGDIR/live
PEM_FILE=cert.pem
PEM_KEY=privkey.pem

RESOURCEGROUP_WAGWAF=matrix-dev-network
WAG_NAME=matrix-wag-dev

. ./run.sh