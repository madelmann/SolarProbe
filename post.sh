#!/bin/sh

./xymon-post.sh %1 https://api.solarprobe.michaeladelmann.at/xymon-report.sh \
    client/bin/badstuff.sh -H example.com

