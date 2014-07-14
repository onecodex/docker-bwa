DOCKER = docker
REPO = quay.io/refgenomics/docker-bwa

TAG = $(git rev-parse --abbrev-ref HEAD 2>/dev/null)
ifeq ($(TAG), master)
	TAG = latest
else ifeq ($(TAG), HEAD)
	TAG = latest
endif

all: release

release: build
	$(DOCKER) push $(REPO)

build:
	$(DOCKER) build -t $(REPO):$(TAG) .