APP=$(shell basename $(shell git remote get-url origin))
REGISTRY=iuriis
VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short  HEAD)
TARGETOS=linux
TARGETARCH=arm64
#TARGETARCH=Darwin
#git describe --tags --abbrev=0
#git rev-parse --short  HEAD
#shell dpkg --print-architecture

format:
	gofmt -s -w ./

get:
	go get

build: format get
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "-X"=github.com/sigella/kbot/cmd.appVersion=${VERSION}

lint:
	golint

test:
	go test -v

image:
	docker build . -t ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}

push:
	docker push ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}

clean:
	rm -rf kbot
