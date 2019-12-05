echo "in cleanup v2"

az network dns record-set txt delete -g $RESOURCEGROUP_DNSZONE -z $CERTBOT_DOMAIN -n '_acme-challenge' --yes