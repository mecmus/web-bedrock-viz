#!/bin/bash
if [ -d ${MapSource:-/source} ]; then
  echo "copy source to working directory"
  cp -r /source /tmp/MapCopy
else
  echo "MapSource not set or not a directory"
  exit 1
fi
if [ -d /usr/share/nginx/html ]; then
  echo "out folder exist"
else
  echo "creating out folder"
  mkdir -p /usr/share/nginx/html
fi
/usr/local/bin/bedrock-viz --db /tmp/MapCopy --out /usr/share/nginx/html --html-all
