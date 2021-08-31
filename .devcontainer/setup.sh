# install curl, git, ...
apt-get update
apt-get install -y curl git jq unzip

useradd -m user
su user

# install go
VERSION='1.14'
OS='linux'
ARCH='amd64'

curl -OL https://dl.google.com/go/go${VERSION}.${OS}-${ARCH}.tar.gz
tar -C /usr/local -xzf go$VERSION.$OS-$ARCH.tar.gz
rm go$VERSION.$OS-$ARCH.tar.gz

INSTALLED_GO_VERSION=$(go version)
echo "Go version ${INSTALLED_GO_VERSION} is installed"

# install gopls, dlv, hey
echo "Getting development tools"
go get -u golang.org/x/tools/gopls
go get -u github.com/go-delve/delve/cmd/dlv
go get -u github.com/rakyll/hey

# vscode-go dependencies 
echo "Getting dependencies for the vscode-go plugin "
# via: https://github.com/microsoft/vscode-go/blob/master/.travis.yml
go get -u -v github.com/acroca/go-symbols
go get -u -v github.com/cweill/gotests/...
go get -u -v github.com/davidrjenni/reftools/cmd/fillstruct
go get -u -v github.com/haya14busa/goplay/cmd/goplay
go get -u -v github.com/mdempsky/gocode
go get -u -v github.com/ramya-rao-a/go-outline
go get -u -v github.com/rogpeppe/godef
go get -u -v github.com/sqs/goreturns
go get -u -v github.com/uudashr/gopkgs/cmd/gopkgs
go get -u -v github.com/zmb3/gogetdoc
go get -u -v golang.org/x/lint/golint
go get -u -v golang.org/x/tools/cmd/gorename

echo "Installing gRPC infos "
curl -OL https://github.com/protocolbuffers/protobuf/releases/download/v3.9.1/protoc-3.9.1-linux-x86_64.zip && \
    unzip -o protoc-3.9.1-linux-x86_64.zip -d /usr/local bin/protoc && \
    unzip -o protoc-3.9.1-linux-x86_64.zip -d /usr/local include/* && \
    rm -rf protoc-3.9.1-linux-x86_64.zip
    
go get -u github.com/golang/protobuf/protoc-gen-go && \
    go get -u github.com/gogo/protobuf/proto && \
    go get -u github.com/gogo/protobuf/gogoproto && \
    go get -u github.com/gogo/protobuf/protoc-gen-gofast && \
    go get -u github.com/gogo/protobuf/protoc-gen-gogo && \
    go get -u github.com/gogo/protobuf/protoc-gen-gogofast && \
    go get -u github.com/gogo/protobuf/protoc-gen-gogofaster && \
    go get -u github.com/gogo/protobuf/protoc-gen-gogoslick && \
    go get -u github.com/pseudomuto/protoc-gen-doc/cmd/protoc-gen-doc

mkdir -p /go/src/github.com/google && \
    git clone --branch master https://github.com/google/protobuf /go/src/github.com/google/protobuf && \
    git clone --branch master https://github.com/openconfig/gnmi /go/src/github.com/openconfig/gnmi && \
    mkdir -p /go/src/github.com/ &&\
    wget "https://github.com/grpc/grpc-web/releases/download/1.0.5/protoc-gen-grpc-web-1.0.5-linux-x86_64" --quiet && \
    mv protoc-gen-grpc-web-1.0.5-linux-x86_64 /usr/local/bin/protoc-gen-grpc-web && \
    chmod +x /usr/local/bin/protoc-gen-grpc-web
