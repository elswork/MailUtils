SNAME ?= mailutils
RNAME ?= elswork/$(SNAME)
ONAME ?= deftwork/$(SNAME)
VER ?= $(shell cat VERSION)
BASE ?= latest
BASENAME ?= debian:bullseye-slim
TARGET_PLATFORM ?= linux/amd64,linux/arm64,linux/ppc64le,linux/s390x,linux/arm/v7,linux/arm/v6
NO_CACHE ?=
MODE ?= $(VER)
CONTAINER_NAME ?= my-mail-sender

# HELP
.PHONY: help

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

# DOCKER TASKS
.PHONY: all build run stop rm rmi clean send-test-mail debug-ssmtp

all: build run

debug: ## Debug the container
	docker build -t $(RNAME):debug \
	--build-arg BASEIMAGE=$(BASENAME) \
	--build-arg VERSION=$(VER) .

build: ## Build the container
	mkdir -p builds
	docker build $(NO_CACHE) -t $(RNAME):$(VER) -t $(RNAME):latest \
	--build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
	--build-arg VCS_REF=`git rev-parse --short HEAD` \
	--build-arg BASEIMAGE=$(BASENAME) \
	--build-arg VERSION=$(VER) \
	. > builds/$(VER)_`date +"%Y%m%d_%H%M%S"`.txt

bootstrap: ## Start multicompiler
	docker buildx inspect --bootstrap

debugx: ## Buildx in Debug mode
	docker buildx build \
	--platform ${TARGET_PLATFORM} \
	-t $(RNAME):debug --pull \
	--build-arg BASEIMAGE=$(BASENAME) \
	--build-arg VERSION=$(VER) .

buildx: ## Buildx the container
	docker buildx build $(NO_CACHE) \
	--platform ${TARGET_PLATFORM} \
	-t ghcr.io/$(ONAME):$(VER) -t ghcr.io/$(ONAME):latest \
	-t $(RNAME):$(VER) -t $(RNAME):latest --pull --push \
	--build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
	--build-arg VCS_REF=`git rev-parse --short HEAD` \
	--build-arg BASEIMAGE=$(BASENAME) \
	--build-arg VERSION=$(VER) .

run: ## Running Docker container
	docker run -d --name $(CONTAINER_NAME) -v "$(PWD)/ssmtp.conf:/etc/ssmtp/ssmtp.conf:ro" $(RNAME):$(MODE)

stop: ## Stopping Docker container
	docker stop $(CONTAINER_NAME)

rm: ## Removing Docker container
	docker rm $(CONTAINER_NAME)

rmi: ## Removing Docker image
	docker rmi $(RNAME):$(VER)
	docker rmi $(RNAME):latest

clean: stop rm rmi ## Cleaned up Docker container and image.

send-test-mail: ## Sending test email
	echo "Este es el cuerpo del correo de prueba desde Docker." | docker exec -i $(CONTAINER_NAME) mail -s "Prueba de MailUtils (Makefile)" elswork@gmail.com

debug-ssmtp: ## Debugging SSMTP connection
	echo -e "To: elswork@gmail.com\nFrom: elswork@gmail.com\nSubject: Debug SSMTP\n\nThis is a debug message." | docker exec -i $(CONTAINER_NAME) ssmtp -v elswork@gmail.com
