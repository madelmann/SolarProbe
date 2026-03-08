#!/bin/bash
set -eu

source "config/base.conf"

OUT="$WWW/servers.html"
ICONDIR="templates/xymon"

NOW="$(date)"
NOW_EPOCH="$(date +%s)"
TTL=300

HOSTS=$(find "$NODES" -mindepth 1 -maxdepth 1 -type d \
  | sed 's#.*/##' | sort)

SERVICES=$(find "$NODES" -name '*.status' \
  | sed 's#.*/##;s/\.status$//' \
  | sort -u)

cat > "$OUT" <<EOF
<!DOCTYPE html>
<html>
<head>
<title>SolarProbe</title>
<style>
body {
  margin: 0;
  background: #000;
  color: #ddd;
  font-family: Arial, Helvetica, sans-serif;
  font-size: 12px;
}
#sidebar {
  position: fixed;
  left: 0;
  top: 0;
  bottom: 0;
  width: 180px;
  background: linear-gradient(to right, #66cc00, #000);
}
#content {
  margin-left: 180px;
  padding: 10px;
}
.header {
  display: flex;
  justify-content: space-between;
  border-bottom: 1px solid #666;
  padding-bottom: 6px;
}
.section {
  margin-top: 20px;
}
table {
  border-collapse: collapse;
}
th, td {
  padding: 2px 6px;
  text-align: center;
}
th {
  color: #8cf;
  font-weight: normal;
}
td.host {
  text-align: left;
  color: #fff;
  white-space: nowrap;
}
a { color: #8cf; text-decoration: none; }
img { border: 0; }
</style>
</head>

<body>
<div id="sidebar"></div>

<div id="content">
  <div class="header">
    <div><b>SolarProbe infrastructure</b></div>
    <div><b>Current Status</b></div>
    <div>$NOW</div>
  </div>

  <div class="section">
    <table>
      <tr>
        <th></th>
EOF

for s in $SERVICES; do
  echo "<th><a href=\"#\">$s</a></th>" >> "$OUT"
done

echo "</tr>" >> "$OUT"

for h in $HOSTS; do
  echo "<tr>" >> "$OUT"
  echo "<td class=\"host\">$h</td>" >> "$OUT"

  for s in $SERVICES; do
    FILE="$NODES/$h/$s.status"

    if [ -f "$FILE" ]; then
      . "$FILE"
      age=$((NOW_EPOCH - timestamp))
      [ "$age" -gt "$TTL" ] && state="blue"
    else
      state="clear"
    fi

    echo "<td><img src=\"$ICONDIR/$state.gif\" alt=\"$state\"></td>" >> "$OUT"
  done

  echo "</tr>" >> "$OUT"
done

cat >> "$OUT" <<EOF
    </table>
  </div>
</div>
</body>
</html>
EOF
