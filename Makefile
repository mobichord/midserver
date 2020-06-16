VERSION=latest
TAG ?=$(VERSION)
NAME_CONTAINER ?=midserver
USER_NAME ?=andrewpgit
IMAGE_NAME ?=$(USER_NAME)/$(NAME_CONTAINER)

.PHONY: help

help:
	@echo ""
	@echo	"rebuild:	- build a Docker image without cache"
	@echo 	"build:		- build a Docker image"
	@echo	"release:	- release a Docker image to Docker Hub"
	@echo	"run:  		- run contailner"
	@echo	"stop:		- stop and remove container"
	@echo	"delete:		- remove images"
	@echo ""

build:
	@echo "Build docker image $(NAME):$(TAG)"
	docker build -t $(IMAGE_NAME):$(TAG) .

rebuild:
	@echo "Build the container without caching"
	docker build  --no-cache -t $(IMAGE_NAME):$(TAG) .

run:
	@echo "Run the container"
	docker run -d --name=$(NAME_CONTAINER) $(IMAGE_NAME):$(TAG)

release:
	@echo "Push docker image to docker hub"
	docker push $(IMAGE_NAME):$(TAG)

stop:
	@echo "Stop and remove a running container"
	docker stop $(NAME_CONTAINER); docker rm $(NAME_CONTAINER)

archive:
		@echo "Archive docker image to ${IMAGE_NAME}.tar"
		docker save -o  image.tar $(IMAGE_NAME)

delete:
	@echo "Remove docker image"
	docker images -q -f label=application=$(NAME_CONTAINER) | xargs -I ARGS docker rmi -f ARGS
