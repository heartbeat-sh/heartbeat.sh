#!/bin/bash

if [[ -z $HAAS_SUBDOMAIN ]]
then
  echo "I don't know what subdomain to ask for your heartbeat status Please run:"
  echo "source setup.sh your-subdomain"
  exit 1
fi

final_status='OK'
URL="https://$HAAS_SUBDOMAIN.heartbeat.sh/heartbeats/txt"

for status in $(curl -s "$URL" | awk '{ print $2 }');
do
  if [[ "$status" == 'WARNING' && "$final_status" == 'OK' ]]
  then
    final_status='WARNING'
  fi
  if [[ "$status" == 'ERROR' ]]
  then
    final_status='ERROR'
  fi
done

echo "$final_status"
