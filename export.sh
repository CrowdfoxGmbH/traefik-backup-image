#!/bin/bash

endpoints=${ENDPOINTS:-http://traefik-etcd-cluster-client:2379}
path=${ACME_PATH:-traefik/acme/account/object}

if [ -z "$ETCDCTL_API" ];then
  export ETCDCTL_API=3
fi

echo "Endpoints: $endpoints; Path: $path; ETCDCTL_API_VERSION: $ETCDCTL_API"

etcdctl --endpoints="$endpoints" get "$path" --prefix --print-value-only --hex  | sed 's/\\x//g' | xxd -r -p | gzip -dc | jq .
