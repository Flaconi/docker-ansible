###
### Default
###
help:
	@printf "%s\n\n" "Flaconi Ansible images"
	@printf "%s\n\n" "make update-base:     Pull latest base image"
	@printf "%s\n"   "make build-all:       Build all images (see below)"
	@printf "%s\n"   "make build-latest:    Build Ansible latest Docker image"
	@printf "%s\n"   "make build-23:        Build Ansible 2.3 Docker image"
	@printf "%s\n"   "make build-24:        Build Ansible 2.4 Docker image"
	@printf "%s\n\n" "make build-25:        Build Ansible 2.5 Docker image"
	@printf "%s\n"   "make test-all:        Test all images (see below)"
	@printf "%s\n"   "make test-latest:     Test Ansible latest Docker image"
	@printf "%s\n"   "make test-23:         Test Ansible 2.3 Docker image"
	@printf "%s\n"   "make test-24:         Test Ansible 2.4 Docker image"
	@printf "%s\n\n" "make test-25:         Test Ansible 2.5 Docker image"


###
### Update
###
update-base:
	docker pull debian:stretch-slim


###
### Build all
###
build-all: build-latest build-23 build-24 build-25


###
### Build Single
###
build-latest: update-base
	docker build -t flaconi/ansible:latest .

build-23: update-base
	docker build --build-arg ANSIBLE_VERSION=2.3 -t flaconi/ansible:2.3 .

build-24: update-base
	docker build --build-arg ANSIBLE_VERSION=2.4 -t flaconi/ansible:2.4 .

build-25: update-base
	docker build --build-arg ANSIBLE_VERSION=2.5 -t flaconi/ansible:2.5 .


###
### Test all
###
test-all: test-latest test-23 test-24 test-25


###
### Build Single
###
test-latest:
	$(eval LATEST = $(shell curl -q https://api.github.com/repos/ansible/ansible/git/refs/tags 2>/dev/null | grep '"ref"' | grep -Eo 'v[.0-9]+' | grep -Eo '[.0-9]+' | sort -Vu | tail -1))
	docker images | grep 'flaconi/ansible' | grep 'latest'
	docker run --rm flaconi/ansible:latest ansible --version | grep "$(LATEST)"

test-23:
	docker images | grep 'flaconi/ansible' | grep '2.3'
	docker run --rm flaconi/ansible:2.3 ansible --version | grep '2.3'

test-24:
	docker images | grep 'flaconi/ansible' | grep '2.4'
	docker run --rm flaconi/ansible:2.4 ansible --version | grep '2.4'

test-25:
	docker images | grep 'flaconi/ansible' | grep '2.5'
	docker run --rm flaconi/ansible:2.5 ansible --version | grep '2.5'
