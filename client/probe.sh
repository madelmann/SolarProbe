#!/bin/sh

. "client/config.conf"

PROBES_CONF="client/probes.conf"

while read -r probe; do
  [ -n "client/extensions/${probe}" ] && api/xymon-post.sh $(hostname) ${SERVER}/solarprobe/api/xymon-report.sh "client/extensions/${probe}"
done < "$PROBES_CONF"

