###
### Default
###
help:
	@printf "%s\n" "make update-base:     Pull latest base image"
	@printf "%s\n" "make build-all:       Build all images (see below)"
	@printf "%s\n" "make build-latest:    Build Ansible latest Docker image"
	@printf "%s\n" "make build-23:        Build Ansible 2.3 Docker image"
	@printf "%s\n" "make build-24:        Build Ansible 2.4 Docker image"
	@printf "%s\n" "make build-25:        Build Ansible 2.5 Docker image"


###
### Build all
###
build-all: build-latest build-23 build-24 build-25


###
### Build Single
###
build-latest:
	docker build -t flaconi/ansible:latest .

build-23:
	docker build --build-arg ANSIBLE_VERSION=2.3 -t flaconi/ansible:2.3 .

build-24:
	docker build --build-arg ANSIBLE_VERSION=2.4 -t flaconi/ansible:2.4 .

build-25:
	docker build --build-arg ANSIBLE_VERSION=2.5 -t flaconi/ansible:2.5 .

update-base:
	docker pull debian:stretch-slim
