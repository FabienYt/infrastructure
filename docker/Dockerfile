FROM python:3.10.7-slim-bullseye

ENV DEBIAN_FRONTEND=noninteractive

ENV DOCKER_TASK=""
ENV DOCKER_LIMIT=""

WORKDIR /ansible

RUN set -x \
    && apt-get update \
    && apt-get install --no-install-recommends --no-install-suggests -y \
       sudo systemd systemd-sysv \
       whois openssh-client pwgen sshpass \
       wget genisoimage xorriso isolinux rsync \
       gzip cpio syslinux gpg dirmngr \
       build-essential libssl-dev libffi-dev \
       python3-pip python3-dev python3-apt python3-setuptools python3-passlib \
    && pip3 install --no-cache-dir --upgrade pip \
    && pip3 install --no-cache-dir ansible ansible-lint bcrypt cryptography jmespath yamllint \
    && apt-get remove --purge --auto-remove -y \
    && rm -rf /var/lib/apt/lists/*

VOLUME /ansible /data

COPY ./docker/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
