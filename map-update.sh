#!/bin/bash
if [ -d /source ]; then
  cp -r /source /tmp/MapCopy
else
  echo "MapSource not set or not a directory"
fi
/usr/local/bin/bedrock-viz --db /tmp/MapCopy --out /usr/share/nginx/html --html-all
