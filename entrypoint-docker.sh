#!/bin/bash

# check config files
for c in /etc/nginx/conf.d/*.conf; do
  echo "Check $c"
  for k in $(awk '/ssl_certificate/ {print $2}' "$c" ); do
    k=${k%;}
    testfile="$k"
    [[ $k == /* ]] || testfile="/etc/nginx/$k"
    echo "PEM: $testfile"
    if [ ! -f "$testfile" ]; then
      dir=$(dirname "$testfile")
      file=$(basename "$testfile")
      mkdir -p "$dir"
      ln -s "/etc/nginx/ssl/$file" "$testfile"
    fi
  done
done

nginx -t

(sleep 5; /certbot.sh) &
exec nginx -g 'daemon off;'
