./certbot-auto \
  certonly \
  --manual \
  -d $DOMAINNAME \
  -d *.$DOMAINNAME \
  -m $EMAILADDRESS \
  --agree-tos \
  --no-eff-email \
  --manual-public-ip-logging-ok \
  --preferred-challenges dns \
  --server https://acme-v02.api.letsencrypt.org/directory \
  --manual-auth-hook certbot-authenticator.sh \
  --manual-cleanup-hook certbot-cleanup.sh \
  --work-dir etc \
  --config-dir $LETSENCRYPT_CONFIGDIR \
  --duplicate \
  --force-renewal \
  --logs-dir log  #--quiet
  
