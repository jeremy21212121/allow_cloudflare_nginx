#!/bin/bash
# Gets cloudflare's IP ranges and formats them as allow rules for nginx
# Useful for preventing IP leaks for sites behind cloudflare
#
# to use, make a cron job `./cloudflare_nginx.sh > /etc/nginx/cloudflare-allow.conf && systemctl restart nginx`
# set cron job to run on your desired interval.
#
# you could also store the file, compare for changes, update cloudflare-allow.conf and restart nginx only if newFile !== oldFile
# I don't imagine cloudflare IPs change that often, so that would save unnecessary restarts of nginx
#
# then in nginx config:
# include /etc/nginx/cloudflare-allow.conf;
# deny all;

set -e;

tempdir=$(mktemp -d);
tempfile=$tempdir/temp.txt;

curl -s https://www.cloudflare.com/ips-v4 > $tempfile;

curl -s https://www.cloudflare.com/ips-v6 >> $tempfile;

# add "allow " prefix and ";" postfix to each line
cat $tempfile | sed -E 's/(.*)/allow \1;/';

# clean up
rm $tempfile;
rm -rf $tempdir;

exit 0;

