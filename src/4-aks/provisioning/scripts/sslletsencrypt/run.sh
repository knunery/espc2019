set -x

# Install Certbot
wget https://dl.eff.org/certbot-auto
chmod a+x ./certbot-auto
./certbot-auto

# (does not work strange enough. Needs more testing. 
# Needed for certbot: Path must contain path to files for manual hooks
# export PATH=$PATH:$(pwd)

# Both files should be executable
chmod +x certbot-authenticator.sh
chmod +x certbot-cleanup.sh
sudo cp 'certbot-authenticator.sh' '/usr/sbin/certbot-authenticator.sh'
sudo cp 'certbot-cleanup.sh' '/usr/sbin/certbot-cleanup.sh'

# Try to read certificate from keyvault
SSLEXPIREDATE=$(az keyvault secret show --name $KEYVAULT_CERTIFICATE_NAME --vault-name $KEYVAULT_NAME --query attributes.expires -o tsv)
if [ $? -eq 0 ];
then    
      # Validate if we need renewal
      END_DATE=$(date -d "$SSLEXPIREDATE" "+%s")      
      CURRENT_DATE=$(date "+%s")
      DAYS_DIFF=$((($END_DATE - $CURRENT_DATE) / 60 / 60 / 24))      
else
    # No certificate in Key Vault, so this is the first time the script runs
    INITIAL=true
fi

if [ $INITIAL ] || [ $DAYS_DIFF -lt $RENEW_THRESHOLD ]; 
then  
  echo "Certificate does not exists or $DAYS_DIFF days old. Renewing now."
  . ./certbot.sh
  echo "Certbot finished."

  # logfiles and certificates are written by certbot. Ensure access
  sudo chmod -R 777 $LETSENCRYPT_CONFIGDIR
  sudo chmod -R 777 log

  sudo ls -lah $LETSENCRYPT_CONFIGDIR/archive/$DOMAINNAME/
  sudo ls -lah $LETSENCRYPT_CONFIGDIR/live/$DOMAINNAME/  

  # Write log of letsencrypt to console to see it in Azure Devops
  cat log/letsencrypt.log

  CERT_PFX=$CERT_DIR/$DOMAINNAME/cert.pfx
  CERT_PEM=$CERT_DIR/$DOMAINNAME/$PEM_FILE

  if sudo [ -e $CERT_PEM ]
  then      
        set -e   
        CERT_PASSWORD=$(openssl rand -base64 32)

        # Convert PEM to PFX
        sudo openssl pkcs12 -inkey $CERT_DIR/$DOMAINNAME/$PEM_KEY \
                 -in $CERT_PEM \
                 -export -out $CERT_PFX \
                 -passout pass:$CERT_PASSWORD

        # "Change rights on pfx"
        sudo ls -lah $CERT_DIR/$DOMAINNAME        
        sudo chmod -R 777 $CERT_DIR/$DOMAINNAME        
        sudo ls -lah $CERT_DIR/$DOMAINNAME

        # Upload pfx to key vault
        az keyvault certificate import --file $CERT_PFX --name $KEYVAULT_CERTIFICATE_NAME --vault-name $KEYVAULT_NAME --password $CERT_PASSWORD

        set +e
        # ONLY IF WAGWAF EXISTS. Initially the script could run before the wag waf is provisioned
        WAGWAFINFO=$(az network application-gateway ssl-cert show -g $RESOURCEGROUP_WAGWAF --gateway-name $WAG_NAME -n $KEYVAULT_CERTIFICATE_NAME)
        if [ $? -eq 0 ];
        then  
          set -e                    
          az network application-gateway ssl-cert create -g $RESOURCEGROUP_WAGWAF --gateway-name $WAG_NAME \                            
                            -n $KEYVAULT_CERTIFICATE_NAME --cert-file $CERT_PFX --cert-password $CERT_PASSWORD
        fi
  else
      echo "Cannot Convert from PEM to PFX because file does not exists. ($CERT_PEM)"
      exit 1
  fi
else
  echo "Certificate still valid for $DAYS_DIFF days, no renewal required."
fi