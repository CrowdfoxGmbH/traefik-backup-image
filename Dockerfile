FROM golang:latest

RUN go get github.com/coreos/etcd/etcdctl && \
    cd /go/src/github.com/coreos/etcd/ && \
    git checkout -b v3.3.4 && \
    CFLAGS="-Wno-error" go install .
RUN apt-get update && \
    apt-get install -y xxd gzip jq

ADD export.sh /

CMD [ "/bin/bash", "/export.sh" ]
