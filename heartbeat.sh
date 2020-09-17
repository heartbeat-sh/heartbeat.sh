#!/bin/bash

if [[ -z $HAAS_SUBDOMAIN ]]
then
  echo "I don't know what subdomain to send your heartbeats to. Please run:"
  echo "source setup.sh your-subdomain"
  exit 1
fi

if [[ -z $1 ]]
then
  echo "Usage: ./heartbeat.sh name [options]"
  exit 1
fi
name=$1
shift

warning=
error=
method="POST"
while [[ $1 ]]; do
  case $1 in
    -w | --warning )
      shift
      warning=$1
      ;;
    -e | --error )
      shift
      error=$1
      ;;
    -d | --delete )
      method="DELETE"
      ;;
  esac
  shift
done

query=""
if [[ $warning ]]
then
  query="?warning=$warning"
fi
if [[ $error ]]
then
  if [[ $query ]]
  then
    query="${query}&"
  else
    query="?"
  fi
  query="${query}error=$error"
fi

url="https://${HAAS_SUBDOMAIN}.heartbeat.sh/beat/${name}${query}"

curl -X "$method" "$url"
