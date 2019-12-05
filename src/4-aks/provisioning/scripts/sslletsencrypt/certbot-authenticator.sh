echo "in authenticator v3"

echo "CERTBOT_VALIDATION $CERTBOT_VALIDATION"
echo "CERTBOT_DOMAIN $CERTBOT_DOMAIN"

az network dns record-set txt add-record -g $RESOURCEGROUP_DNSZONE -z $CERTBOT_DOMAIN -n '_acme-challenge' --value $CERTBOT_VALIDATION

# Give the DNS time to process the new settings
sleep 60