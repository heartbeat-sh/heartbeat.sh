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

PROTO=https
HOST=heartbeat.sh
if [[ $DEBUG ]]
then
  PROTO=http
  HOST=localhost:8123
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

URL="$PROTO://$HAAS_SUBDOMAIN.$HOST/beat/$1$QUERY"

curl -X POST "$URL"