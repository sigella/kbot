APP = $(shell basename -s .git $(shell git remote get-url origin))
REGISTRY = sigella
IMAGEREGISTRY = ghcr.io
VERSION = $(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short  HEAD)
TARGETOS ?= linux						# linux, darwin, windows
#TARGETARCH ?= $(shell uname -m)						# arm64, amd64

# Set target architecture and toolchain if cross-compiling
ifeq ($(shell uname -m),x86_64)
    TARGETARCH = amd64
else
	TARGETARCH = $(shell uname -m)
endif

format:
	gofmt -s -w ./

get:
	go get

build: format get
	CGO_ENABLED=0 GOOS=$(TARGETOS) GOARCH=$(TARGETARCH) go build -v -o kbot -ldflags "-X"=github.com/sigella/kbot/cmd.appVersion=$(VERSION)

linux:
	@$(MAKE) build TARGETOS=linux TARGETARCH=$(TARGETARCH)

macos:
	@$(MAKE) build TARGETOS=darwin TARGETARCH=$(TARGETARCH)

windows:
	@$(MAKE) build TARGETOS=windows TARGETARCH=$(TARGETARCH)

arm:
	@$(MAKE) build TARGETOS=linux TARGETARCH=arm64

lint:
	golint

test:
	go test -v

image:
	docker build --platform linux/$(TARGETARCH) --build-arg TARGETARCH=$(TARGETARCH) -t $(REGISTRY)/$(APP):$(VERSION)-$(TARGETARCH) .

push:
	docker push $(IMAGEREGISTRY)/$(REGISTRY)/$(APP):$(VERSION)-$(TARGETARCH)

clean:
	rm -rf kbot
	docker rmi $(REGISTRY)/$(APP):$(VERSION)-$(TARGETARCH) || true
