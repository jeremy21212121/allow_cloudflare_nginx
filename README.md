# allow_cloudflare_nginx

Bash script for retrieving cloudflares IP ranges and formatting them as nginx allow rules.

For example, IP range `192.168.0.1/24` becomes `allow 192.168.0.1/24;`

This is useful for only allowing connections from cloudflare for sites that are behind cloudflare. This can help prevent leaking the servers true IP address.

## examples

format IPs as `allow` rules and save them to a file

```
./cloudflare_nginx.sh > /etc/nginx/cloudflare-allow.conf
```

in your nginx config

```
server {

include /etc/nginx/cloudflare-allow.conf;
deny all;

}
```

Et voila, now your server is only reachable through cloudflare. It would be a good idea to set a cron job to update the IPs and restart nginx as often as you see fit.


