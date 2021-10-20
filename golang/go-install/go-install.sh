#!/bin/bash

echo "Removing the current version ..."

sudo apt update -y >/dev/null 2>&1
sudo apt remove golang-go -y >/dev/null 2>&1

sudo rm -rf /usr/local/go

VERSION=`curl -s https://golang.org/VERSION?m=text`
ARCH=`uname -m`

if [ -z "${ARCH##*armv*}" ]; then
	ARCH=armv6l
fi

if [ -z "${ARCH##*x86_64*}" ]; then
        ARCH=amd64
fi

echo "Downoading https://golang.org/dl/${VERSION}.linux-${ARCH}.tar.gz"

wget -q https://golang.org/dl/$VERSION.linux-$ARCH.tar.gz -O $VERSION.tar.gz

echo "Installing Go ${VERSION} ..."
sudo tar -C /usr/local -xzf $VERSION.tar.gz

rm $VERSION.tar*

source ./go-path

mkdir $HOME/golib $HOME/code  >/dev/null 2>&1

echo "Installing Go tools ..."

go get -u -v github.com/nsf/gocode
go get -u -v github.com/rogpeppe/godef
go get -u -v golang.org/x/lint/golint
go get -u -v sourcegraph.com/sqs/goreturns
go get -u -v golang.org/x/tools/cmd/gorename
go get -u -v github.com/tpng/gopkgs
go get -u -v github.com/newhook/go-symbols
go get -u -v golang.org/x/tools/cmd/guru
go get -v golang.org/x/tools/gopls
go get -v github.com/ramya-rao-a/go-outline
go get -v github.com/uudashr/gopkgs/v2/cmd/gopkgs
go get -v github.com/go-delve/delve/cmd/dlv

go version

echo "Installation completed."
