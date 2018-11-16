FROM nginx:1.15-alpine
LABEL maintainer="s.bondarev@southbridge.ru"

ENV TOS="--agree-tos"

RUN apk update \
    && apk add --no-progress \
        bash certbot openssl  \
    && rm /var/cache/apk/* \
    && echo "preparing certbot webroot" \
    && mkdir -p /var/www/letsencrypt

VOLUME ["/etc/letsencrypt"]

COPY nginx /etc/nginx
COPY certbot.sh /
COPY entrypoint-docker.sh /

CMD ["/entrypoint-docker.sh"]
