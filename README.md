# Nginx with Letsencrypt certificate

put your server{} config file into /etc/nginx/conf.d/*.conf

set in config

```
listen 443 ssl;
server_name domain.net;

ssl_certificate /etc/letsencrypt/live/domain.net/fullchain.pem;
ssl_certificate_key  /etc/letsencrypt/live/domain.net/privkey.pem;

include letsencrypt.conf;
```

docker-entrypoin.sh scan all *.conf file in /etc/nginx/conf.d/ and get letsencrypt certificate for new domain, and renew for existings

## env variable:
```
EMAIL=test@test.net ## email for letsencrypt account
DRY_RUN=1           ## get test/staged certficiate from letsencrypt
```
## Example with volume
```
docker build . --tag nginx-certbot
docker run -d --name lb -p 80:80 -p 443:443 -v /opt/ssl:/etc/letsencrypt nginx-certbot
```
## Renew cert
```
docker exec -it lb certbot.sh
```
## Force renew cert
```
docker exec -it lb certbot-force-renew.sh
```