# docker pull certbot/certbot
# https://certbot.eff.org/docs/using.html#pre-and-post-validation-hooks
# https://www.bennadel.com/blog/3420-obtaining-a-wildcard-ssl-certificate-from-letsencrypt-using-the-dns-challenge.htm
# -d espc18.cf `
#   -d *.espc18.cf `
docker run -it --rm --name letsencrypt `
  -v "C:/unicerts/etc:/etc/letsencrypt" `
  -v "C:/unicerts/log:/var/log/letsencrypt" `
  -v "C:/unicerts/:/usr/sbin" `
  -v "C:/unicerts/lib:/var/lib/letsencrypt" certbot/certbot `
  certonly `
  --manual `
  -d *.voxxed.cf `
  -d voxxed.cf `
  -m pnaber@xpirit.com `
  --agree-tos `
  --no-eff-email `
  --manual-public-ip-logging-ok `
  --preferred-challenges dns `
  --server https://acme-v02.api.letsencrypt.org/directory `
  --dry-run `
  --manual-auth-hook certbot-authenticator.sh `
  --manual-cleanup-hook certbot-cleanup.sh

  # esdi56sDuU9kcF4sRLq6sJl_xvD-oeljrDjDa-iL1Eo