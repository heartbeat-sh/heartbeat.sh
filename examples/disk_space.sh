#!/bin/bash

interval=60
name="disk-space"
usage=75
while [[ $1 ]]; do
  case $1 in
    -i | --interval )
      shift
      interval=$1
      ;;
    -n | --name )
      shift
      name=$1
      ;;
    -u | --usage )
      shift
      usage=$1
      ;;
  esac
  shift
done

if [[ "$(df | awk '$6 == "/" {gsub(/%/, "", $5); print $5}')" -lt "$usage" ]]
then
  ../heartbeat.sh "$name" -w $((interval + 1))m -e $((interval * 2))m
fi
