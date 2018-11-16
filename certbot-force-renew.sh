#!/bin/bash

certbot renew --force-renew
nginx -t

nginx -s reload
