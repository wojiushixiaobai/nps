#!/bin/bash
export VERSION=0.26.10
GOFlAGS="-s -w -extldflags -static"

if [ ! -d "./build" ]; then
    mkdir -p ./build
fi

rm -rf ./build/*

for ARCH in amd64 arm64 loong64; do
    CGO_ENABLED=0 GOOS=linux GOARCH=${ARCH} go build -ldflags "${GOFlAGS}" ./cmd/npc/npc.go
    tar -czf ./build/linux_${ARCH}_client.tar.gz npc conf/npc.conf conf/multi_account.conf
    rm -f npc
done

for ARCH in amd64 arm64 loong64; do
    CGO_ENABLED=0 GOOS=linux GOARCH=${ARCH} go build -ldflags "${GOFlAGS}" ./cmd/nps/nps.go
    tar -czf ./build/linux_${ARCH}_server.tar.gz conf/nps.conf conf/tasks.json conf/clients.json conf/hosts.json conf/server.key  conf/server.pem web/views web/static nps
    rm -f nps
done