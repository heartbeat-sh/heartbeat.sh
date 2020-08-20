if [[ -z $1 ]]
then
  echo "WARNING: Subdomain not specified, this will undo your heartbeat setup"
fi

export HAAS_SUBDOMAIN="$1"
