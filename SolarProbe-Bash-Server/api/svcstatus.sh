#!/usr/bin/env bash

source "config/base.conf"


# CGI-Header
echo "Content-Type: text/plain"
echo

# Query-String einlesen
QS="$QUERY_STRING"

# Parameter extrahieren
HOST=$(printf '%s\n' "$QS" | tr '&' '\n' | awk -F= '$1=="HOST"{print $2}')
SERVICE=$(printf '%s\n' "$QS" | tr '&' '\n' | awk -F= '$1=="SERVICE"{print $2}')

# einfache Validierung
if [ -z "$HOST" ] || [ -z "$SERVICE" ]; then
  echo "ERROR: HOST und SERVICE müssen angegeben werden"
  exit 1
fi

# Pfad zur Statusdatei
FILE="$NODES/$HOST/$SERVICE.status"

if [ ! -f "$FILE" ]; then
  echo "ERROR: Statusdatei nicht gefunden"
  exit 1
fi

# Datei ausgeben
cat "$FILE"
