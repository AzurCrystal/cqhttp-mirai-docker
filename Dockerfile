FROM debian:buster-slim

LABEL Maintainer="AzurCrystal"

ARG PUID=1000

ENV TZ="Asia/Shanghai"

RUN set -x \
    && cp /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} >/etc/timezone \
    && apt-get update \
    && apt-get install -y --no-install-recommends --no-install-suggests \
        wget \
        ca-certificates \
    && useradd -u $PUID -m mirai \
    && su mirai -c \
        "mkdir -p /home/mirai/mirai/plugins/CQHTTPMirai \
        && cd /home/mirai/mirai \
        && wget https://scyb.pcr.works:34767/114EEF36CEA19E2846ECB149E88899AC -O miraiOK \
        && chmod 755 miraiOK \
        && cd plugins \
        && wget https://github.com/yyuueexxiinngg/cqhttp-mirai/releases/download/0.1.6/cqhttp-mirai-0.1.6-fix1-all.jar " \
    && apt-get remove --purge -y wget \
	&& apt-get clean autoclean \
	&& apt-get autoremove -y \
	&& rm -rf /var/lib/apt/lists/*

VOLUME /home/mirai/mirai

USER mirai

WORKDIR /home/mirai/mirai

ENTRYPOINT /home/mirai/mirai/miraiOK