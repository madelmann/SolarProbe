#!/bin/bash

DIRECTORY=$(dirname "$0")
EXTENSION_DIRECTORY="${DIRECTORY}/extensions"

SYSTEMS_CONF="${DIRECTORY}/config/systems.conf"

while read -r host; do

  PROBES_CONF="${DIRECTORY}/config/probes.conf"

  echo "Host: $host"

  while read -r probe; do

    if [ -f "${EXTENSION_DIRECTORY}/${probe}" ]; then

      echo "Probing $probe..."

      ${DIRECTORY}/api/post.sh "${SERVER}/api/report.sh" "$host" "${EXTENSION_DIRECTORY}/${probe}"

    fi

  done < "$PROBES_CONF"

done < "$SYSTEMS_CONF"

