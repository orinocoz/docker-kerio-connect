FROM lsiobase/ubuntu:bionic

LABEL maintainer="starcraft66@gmail.com"

ARG DEBIAN_FRONTEND="noninteractive"
ARG KERIO_CONNECT_NOT_RUN="yes"

RUN curl -L http://download.kerio.com/dwn/kerio-connect-linux-64bit.deb > /tmp/kerio.deb && \
    dpkg -i /tmp/kerio.deb || true && \
    apt-get update && \
    apt-get -f -y install && \
    apt-get -y upgrade && \
    dpkg --fsys-tarfile /tmp/kerio.deb | tar xOf - ./etc/init.d/kerio-connect > /kerio-connect && \
    chmod +x /kerio-connect && \
    rm -rf \
        /tmp/* \
        /var/lib/apt/lists/* \
        /var/tmp/*

COPY root/ /

EXPOSE 25 80 110 119 143 389 443 465 563 587 636 993 995 4040 5222 5223

VOLUME /opt/kerio/mailserver