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
	@printf "%s\n"   "make build-25:        Build Ansible 2.5 Docker image"
	@printf "%s\n\n" "make build-26:        Build Ansible 2.6 Docker image"
	@printf "%s\n\n" "make build-27:        Build Ansible 2.7 Docker image"
	@printf "%s\n"   "make test-all:        Test all images (see below)"
	@printf "%s\n"   "make test-latest:     Test Ansible latest Docker image"
	@printf "%s\n"   "make test-23:         Test Ansible 2.3 Docker image"
	@printf "%s\n"   "make test-24:         Test Ansible 2.4 Docker image"
	@printf "%s\n"   "make test-25:         Test Ansible 2.5 Docker image"
	@printf "%s\n\n" "make test-26:         Test Ansible 2.6 Docker image"
	@printf "%s\n\n" "make test-27:         Test Ansible 2.7 Docker image"


###
### Update
###
update-base:
	docker pull debian:stretch-slim


###
### Build all
###
build-all: build-latest build-latest-aws build-23 build-23-aws build-24 build-24-aws build-25 build-25-aws build-26 build-26-aws build-27 build-27-aws


###
### Build Single
###
build-latest: update-base
	docker build -t flaconi/ansible:latest .

build-latest-aws: build-latest
	docker build --build-arg ANSIBLE_VERSION=latest -t flaconi/ansible:latest-aws -f ./Dockerfile.aws .

build-23: update-base
	docker build --build-arg ANSIBLE_VERSION=2.3 -t flaconi/ansible:2.3 .

build-23-aws: build-23
	docker build --build-arg ANSIBLE_VERSION=2.3 -t flaconi/ansible:2.3-aws -f ./Dockerfile.aws .

build-24: update-base
	docker build --build-arg ANSIBLE_VERSION=2.4 -t flaconi/ansible:2.4 .

build-24-aws: build-24
	docker build --build-arg ANSIBLE_VERSION=2.4 -t flaconi/ansible:2.4-aws -f ./Dockerfile.aws .

build-25: update-base
	docker build --build-arg ANSIBLE_VERSION=2.5 -t flaconi/ansible:2.5 .

build-25-aws: build-25
	docker build --build-arg ANSIBLE_VERSION=2.5 -t flaconi/ansible:2.5-aws -f ./Dockerfile.aws .

build-26: update-base
	docker build --build-arg ANSIBLE_VERSION=2.6 -t flaconi/ansible:2.6 .

build-26-aws: build-26
	docker build --build-arg ANSIBLE_VERSION=2.6 -t flaconi/ansible:2.6-aws -f ./Dockerfile.aws .

build-27: update-base
	docker build --build-arg ANSIBLE_VERSION=2.7 -t flaconi/ansible:2.7 .

build-27-aws: build-27
	docker build --build-arg ANSIBLE_VERSION=2.7 -t flaconi/ansible:2.7-aws -f ./Dockerfile.aws .


###
### Test all
###
test-all: test-latest test-latest-aws test-23 test-23-aws test-24 test-24-aws test-25 test-25-aws test-26 test-26-aws test-27 test-27-aws


###
### Build Single
###
test-latest:
	$(eval LATEST = $(shell curl -q https://api.github.com/repos/ansible/ansible/git/refs/tags 2>/dev/null | grep '"ref"' | grep -Eo 'v[.0-9]+"' | grep -Eo '[.0-9]+' | sort -Vu | tail -1))
	docker images | grep 'flaconi/ansible' | grep -E 'latest\s'
	docker run --rm flaconi/ansible:latest ansible --version | grep "$(LATEST)"

test-latest-aws:
	docker images | grep 'flaconi/ansible' | grep 'latest-aws'
	docker run --rm flaconi/ansible:latest-aws ansible --version | grep "$(LATEST)"
	docker run --rm flaconi/ansible:latest-aws aws --version 2>&1 | grep -E '^aws-cli/[.0-9]+'
	docker run --rm flaconi/ansible:latest-aws kubectl version --client --short=true 2>&1 | grep -E 'v[.0-9]+'
	docker run --rm flaconi/ansible:latest-aws kops version | grep -E '^Version\s+[.0-9]+'

test-23:
	docker images | grep 'flaconi/ansible' | grep -E '2.3\s'
	docker run --rm flaconi/ansible:2.3 ansible --version | grep '2.3'

test-23-aws:
	docker images | grep 'flaconi/ansible' | grep '2.3-aws'
	docker run --rm flaconi/ansible:2.3-aws ansible --version | grep '2.3'
	docker run --rm flaconi/ansible:2.3-aws aws --version 2>&1 | grep -E '^aws-cli/[.0-9]+'
	docker run --rm flaconi/ansible:2.3-aws kubectl version --client --short=true 2>&1 | grep -E 'v[.0-9]+'
	docker run --rm flaconi/ansible:2.3-aws kops version | grep -E '^Version\s+[.0-9]+'

test-24:
	docker images | grep 'flaconi/ansible' | grep -E '2.4\s'
	docker run --rm flaconi/ansible:2.4 ansible --version | grep '2.4'

test-24-aws:
	docker images | grep 'flaconi/ansible' | grep '2.4-aws'
	docker run --rm flaconi/ansible:2.4-aws ansible --version | grep '2.4'
	docker run --rm flaconi/ansible:2.4-aws aws --version 2>&1 | grep -E '^aws-cli/[.0-9]+'
	docker run --rm flaconi/ansible:2.4-aws kubectl version --client --short=true 2>&1 | grep -E 'v[.0-9]+'
	docker run --rm flaconi/ansible:2.4-aws kops version | grep -E '^Version\s+[.0-9]+'

test-25:
	docker images | grep 'flaconi/ansible' | grep -E '2.5\s'
	docker run --rm flaconi/ansible:2.5 ansible --version | grep '2.5'

test-25-aws:
	docker images | grep 'flaconi/ansible' | grep '2.5-aws'
	docker run --rm flaconi/ansible:2.5-aws ansible --version | grep '2.5'
	docker run --rm flaconi/ansible:2.5-aws aws --version 2>&1 | grep -E '^aws-cli/[.0-9]+'
	docker run --rm flaconi/ansible:2.5-aws kubectl version --client --short=true 2>&1 | grep -E 'v[.0-9]+'
	docker run --rm flaconi/ansible:2.5-aws kops version | grep -E '^Version\s+[.0-9]+'

test-26:
	docker images | grep 'flaconi/ansible' | grep -E '2.6\s'
	docker run --rm flaconi/ansible:2.6 ansible --version | grep '2.6'

test-26-aws:
	docker images | grep 'flaconi/ansible' | grep '2.6-aws'
	docker run --rm flaconi/ansible:2.6-aws ansible --version | grep '2.6'
	docker run --rm flaconi/ansible:2.6-aws aws --version 2>&1 | grep -E '^aws-cli/[.0-9]+'
	docker run --rm flaconi/ansible:2.6-aws kubectl version --client --short=true 2>&1 | grep -E 'v[.0-9]+'
	docker run --rm flaconi/ansible:2.6-aws kops version | grep -E '^Version\s+[.0-9]+'

test-27:
	docker images | grep 'flaconi/ansible' | grep -E '2.7\s'
	docker run --rm flaconi/ansible:2.7 ansible --version | grep '2.7'

test-27-aws:
	docker images | grep 'flaconi/ansible' | grep '2.7-aws'
	docker run --rm flaconi/ansible:2.7-aws ansible --version | grep '2.7'
	docker run --rm flaconi/ansible:2.7-aws aws --version 2>&1 | grep -E '^aws-cli/[.0-9]+'
	docker run --rm flaconi/ansible:2.7-aws kubectl version --client --short=true 2>&1 | grep -E 'v[.0-9]+'
	docker run --rm flaconi/ansible:2.7-aws kops version | grep -E '^Version\s+[.0-9]+'
