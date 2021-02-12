DOCKER_DIR      := base
DOCKER_NAME     := quartus
DOCKER_VERSION  := v20.1.1

build:
	docker build -t $(DOCKER_NAME):$(DOCKER_VERSION) $(DOCKER_DIR)

.PHONY: build
