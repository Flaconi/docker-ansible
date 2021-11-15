FROM debian:bullseye-slim

LABEL maintainer="devops@flaconi.de"

ARG ANSIBLE_VERSION=

RUN set -x \
	&& DEBIAN_FRONTEND=noninteractive \
	&& apt-get update -y \
	&& apt-get install --no-install-recommends --no-install-suggests -y \
		apt-transport-https \
		bc \
		ca-certificates \
		git \
		gnupg \
		libssl-dev \
		python3-dev \
		python3-setuptools \
		python3-wheel \
		python3-pip \
		python3-cffi \
		build-essential \
	&& if [ -z "${ANSIBLE_VERSION}" ]; then \
			pip3 install --no-cache-dir ansible-core;\
		else \
			pip3 install --no-cache-dir "ansible>=${ANSIBLE_VERSION},<$(echo "$(echo ${ANSIBLE_VERSION}|cut -f1 -d.).$(echo ${ANSIBLE_VERSION}+1|cut -f2 -d.|bc)")"; \
		fi \
	&& pip3 install --no-cache-dir \
		jmespath \
		pyaml \
	&& apt-get remove -f -y --purge --auto-remove build-essential bc \
	&& apt-get clean \
	&& apt-get autoremove -y \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /root/.cache
