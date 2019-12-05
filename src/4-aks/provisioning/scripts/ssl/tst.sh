#DRYRUN='--dry-run'
#DRYRUN=--dry-run
var=${DRYRUN:=""}

echo $var
az keyvault certificate import --file ./letsencrypt/archive/espc18.cf/cert.pfx --name matrix-ssl-certificate --vault-name matrix-secrets-dev


END_DATE=$(date -d "$(az keyvault secret show --name matrix-ssl-certificate --vault-name matrix-secrets-dev --query attributes.expires -o tsv)" "+%s")

echo $END_DATE
CURRENT_DATE=$(date "+%s")
      DAYS_DIFF=$((($END_DATE - $CURRENT_DATE) / 60 / 60 / 24))
      echo $DAYS_DIFF
--file $CERTIFICATE_PATH -e base64 --name $KEYVAULT_CERTIFICATE_NAME --vault-name $KEYVAULT_NAME

openssl pkcs12 -in matrix-ssl-certificate.pfx -out tmpcert.pem -nodes -passin pass:
openssl pkcs12 -export -out matrix-ssl-certificate.pfx -in tmpcert.pem -passout pass:welkom

echo | openssl pkcs12 -in matrix-ssl-certificate.pfx -nokeys -passin pass:welkom | openssl x509 -noout -enddate
#notAfter=Apr 18 10:55:35 2019 GMT