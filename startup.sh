#!/bin/bash
echo "${GENMAP_CRON:-"*/30 * * * *"} /map-update.sh >> /var/log/cron.log 2>&1" > /cron-file
crontab /cron-file
/usr/sbin/cron
nginx -g 'daemon off;'