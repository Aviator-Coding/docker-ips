FROM    frolvlad/alpine-glibc
LABEL   maintainer="Aviator" \
        discord="Aviator#1024"

ENV VERSION=v3.1.0.0
ENV GITHUB_AUTOR="ipsum-network"
ENV GITHUB_REPO=ips
ENV GITHUB_TAR=ips-3.1.0-linux.tar.gz

RUN apk add --no-cache curl && \
    curl -L https://github.com/$GITHUB_AUTOR/$GITHUB_REPO/releases/download/$VERSION/$GITHUB_TAR | tar zx -C /tmp &&\
    find /tmp -name "ips-cli" -exec cp {} /usr/local/bin \; &&\ 
    find /tmp -name "ipsd" -exec cp {} /usr/local/bin \; &&\
    rm -r /tmp/* &&\
    apk del curl

VOLUME ["/root/.ips"]

EXPOSE 22331/tcp

CMD ipsd -printtoconsole
