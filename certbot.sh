#!/bin/bash

export TOS="--agree-tos"

if [ -z "$EMAIL" ]; then
  email_opt="--register-unsafely-without-email"
else
  email_opt="--email $EMAIL"
fi

typeset test_cert_opt=""
[ -n "$DRY_MODE" ] && test_cert_opt=--test-cert

for d in /etc/letsencrypt/live/*; do
  [ -d "$d" ] || continue
  cert=$(basename "$d")
  echo "Create/update sertificate for: $cert"
  [ ! -d "/etc/letsencrypt/archive/$cert" ] && rm -rf "/etc/letsencrypt/live/$cert"
echo "certbot certonly --noninteractive --no-self-upgrade --webroot --webroot-path /var/www/letsencrypt --agree-tos $email_opt   --renew-with-new-domains ${test_cert_opt} -d ${cert}"
  certbot certonly --noninteractive --no-self-upgrade --webroot --webroot-path /var/www/letsencrypt --agree-tos $email_opt   --renew-with-new-domains "${test_cert_opt}" -d "${cert}"
done

nginx -t
nginx -s reload
