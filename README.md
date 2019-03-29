Traefik-backup-image
======================


This image is intended to be used to export acme certificates from etcd.

Libraries
-----------

To be able to do so, this image contains:
* etcdctl obviously to communicate with the ETCD cluster
* xxd in order to decode the hex output of the etcd values. (This has to be done to make sure that those gziped values don't break, while getting them)
* gzip to unzip those values which are compressed in order to store all certs into one bucket
* jq  to prettyfy the output.

Usage
---------

To use this bare, just run:

`kubectl run --namespace kube-system  --rm -it traefik-etcd-backup --image=crowdfox/traefik-backup-image:latest --restart=Never --env="ETCDCTL_API=3" -l app=traefik /export.sh`

Note: the `app=traefik` label is needed in Crowdfox context as we are using a network policy that only container labeled like that are allowed to access the etcd cluster.
If you are using telepresence.io you have to label the according telepresence container with `app=traefik` in order to make this container work.

Hopefully this mechanism will be accepted in the stable Helm Chart repo of Traefik. Then this will be installed right away when you are using Traefik with ETCD and an external Persistent Volume (Like NFS or CephFS)
