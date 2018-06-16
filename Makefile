.PHONY: all test clean man fast release install

GO15VENDOREXPERIMENT=1

PROG_NAME := "iochan"

all: test build example install version

build:
	@go build -ldflags "-X main.VERSION=`cat VERSION`" -o ./bin/$(PROG_NAME) ./cmd/$(PROG_NAME)/*.go

example-all: example-run example-build

example-build:
	@go build -ldflags "-X main.VERSION=`cat VERSION`" -o ./bin/$(PROG_NAME)-example ./example/*.go

example-run:
	@go run -ldflags "-X main.VERSION=`cat VERSION`" ./example/*.go

version:
	@which $(PROG_NAME)
	@$(PROG_NAME) --version

install: deps
	@go install -ldflags "-X main.VERSION=`cat VERSION`" ./cmd/$(PROG_NAME)
	@$(PROG_NAME) --version

fast: deps
	@go build -i -ldflags "-X main.VERSION=`cat VERSION`-dev" -o ./bin/$(PROG_NAME) ./cmd/$(PROG_NAME)/*.go
	@$(PROG_NAME) --version

deps-ci:
	@go get -v -u github.com/go-playground/overalls
	@go get -v -u github.com/mattn/goveralls
	@go get -v -u golang.org/x/tools/cmd/cover

test:
	@go test ./pkg/...

clean:
	@go clean
	@rm -fr ./bin
	@rm -fr ./dist

release: $(PROG_NAME)
	@git tag -a `cat VERSION`
	@git push origin `cat VERSION`

