#!/bin/bash

if [[ -z $HAAS_SUBDOMAIN ]]
then
  echo "I don't know what subdomain to send your heartbeats to. Please run:"
  echo "source setup.sh your-subdomain"
  exit 1
fi

if [[ -z $1 ]]
then
  echo "Usage: ./heartbeat.sh name [warning-timeout] [error-timeout]"
  exit 1
fi

QUERY=""
if [[ $2 ]]
then
  QUERY="?warning=$2"
fi
if [[ $3 ]]
then
  QUERY="$QUERY&error=$3"
fi

URL="https://$HAAS_SUBDOMAIN.heartbeat.sh/beat/$1$QUERY"

curl -X POST "$URL"
