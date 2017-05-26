#!/bin/bash

set -e
# set -x

function upAndRunning() {
  response=$(curl --write-out %{http_code} --output /dev/null --silent --head --fail http://$API_PORT_80_TCP_ADDR:$API_PORT_5121_TCP_PORT/v1/status)

  if [ $response -eq 200 ] || [ $response -eq 405 ]; then
    echo 1;
  else
    echo 0;
  fi
}

counter=0
while [[ `upAndRunning` -eq 0 ]]; do
  counter=$((counter+1));
  if [ $counter -eq 90 ]; then break; fi;
  sleep 20;
done

export PUBLIC_GFB_DOMAINS="$PUBLIC_GFB_DOMAINS,$VARNISH_PORT_80_TCP_ADDR"

if [[ $API_PORT_80_TCP_ADDR ]]; then
  export GFB_API_BACKEND_URL=http://$API_PORT_80_TCP_ADDR:$API_PORT_5121_TCP_PORT/v1
fi

cd $APP_HOME/frontend && node server.js # > /dev/null 2>&1 &
