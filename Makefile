###
### Default
###
help:
	@printf "%s\n" "make build-all:          Build all images"
	@printf "%s\n" "make build-amazon-all:   Build all Amazon Linux images"
	@printf "%s\n" "make build-centos-all:   Build all CentOS Linux images"
	@printf "%s\n" "make build-debian-all:   Build all Debian Linux images"
	@printf "%s\n" "make build-oracle-all:   Build all Oracle Linux images"


###
### Build all
###
build-all: build-amazon-all build-centos-all build-debian-all build-oracle-all


###
### Build Amazon
###
build-amazon-all: build-amazon-2016 build-amazon-2017

build-amazon-2016:
	docker build -t flaconi/ansible:amazon-2016-09 -f amazon/2016.09/Dockerfile amazon/2016.09
build-amazon-2017:
	docker build -t flaconi/ansible:amazon-2017-03 -f amazon/2017.03/Dockerfile amazon/2017.03


###
### Build CentOS
###
build-centos-all: build-centos-7

build-centos-7:
	docker build -t flaconi/ansible:centos7 -f centos/7/Dockerfile centos/7


###
### Build Debian
###
build-debian-all: build-debian-jessie build-debian-jessie-slim build-debian-stretch build-debian-stretch-slim build-debian-stretch-aws-slim build-debian-wheezy build-debian-wheezy-slim build-debian-wheezy-aws build-debian-wheezy-aws-slim

build-debian-jessie:
	docker build -t flaconi/ansible:debian-jessie -f debian/jessie/Dockerfile debian/jessie
build-debian-jessie-slim:
	docker build -t flaconi/ansible:debian-jessie-slim -f debian/jessie/slim.Dockerfile debian/jessie

build-debian-stretch:
	docker build -t flaconi/ansible:debian-stretch -f debian/stretch/Dockerfile debian/stretch
build-debian-stretch-slim:
	docker build -t flaconi/ansible:debian-stretch-slim -f debian/stretch/slim.Dockerfile debian/stretch
build-debian-stretch-aws-slim:
	docker build -t flaconi/ansible:debian-stretch-aws-slim -f debian/stretch/aws-slim.Dockerfile debian/stretch

build-debian-wheezy:
	docker build -t flaconi/ansible:debian-wheezy -f debian/wheezy/Dockerfile debian/wheezy
build-debian-wheezy-slim:
	docker build -t flaconi/ansible:debian-wheezy-slim -f debian/wheezy/slim.Dockerfile debian/wheezy
build-debian-wheezy-aws:
	docker build -t flaconi/ansible:debian-wheezy-aws -f debian/wheezy/aws.Dockerfile debian/wheezy
build-debian-wheezy-aws-slim:
	docker build -t flaconi/ansible:debian-wheezy-aws-slim -f debian/wheezy/aws-slim.Dockerfile debian/wheezy


###
### Build Oracke
###
build-oracle-all: build-oracle-7

build-oracle-7:
	docker build -t flaconi/ansible:oracle7 -f oracle/7/Dockerfile oracle/7
