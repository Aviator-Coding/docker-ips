ARG BDB_VERSION="4.8.30.NC"

FROM lepetitbloc/bdb:$BDB_VERSION

ARG USE_UPNP=1
ENV USE_UPNP=$USE_UPNP

EXPOSE 22333 22334

RUN apt-get update -y && apt-get install -y \
    libssl-dev \
    libboost-system-dev \
    libboost-filesystem-dev \
    libboost-chrono-dev \
    libboost-program-options-dev \
    libboost-test-dev \
    libboost-thread-dev \
    libminiupnpc-dev \
    libqrencode-dev \
    libgmp-dev \
    libevent-dev \
    libzmq3-dev \
    automake \
    pkg-config \
    git \
    bsdmainutils \
&& rm -rf /var/lib/apt/lists/* \
&& useradd -lrUm ips \
&& git clone --depth 1 https://github.com/ipsum-network/ips.git /tmp/ips
WORKDIR /tmp/ips

# build
RUN chmod +x autogen.sh share/genbuild.sh src/leveldb/build_detect_platform \
&& ./autogen.sh \
&& ./configure CPPFLAGS="-I/usr/local/db4/include -O2" LDFLAGS="-L/usr/local/db4/lib" \
&& make \
&& strip src/ipsd src/ips-cli src/ips-tx \
&& mv src/ipsd /usr/local/bin/ \
&& mv src/ips-cli /usr/local/bin/ \
&& mv src/ips-tx /usr/local/bin/ \
# clean
&& rm -rf /tmp/ips

USER ips

WORKDIR /home/ips

RUN mkdir -p .ips data

COPY wallet/.ips/ .ips/

ENTRYPOINT ["/usr/local/bin/ipsd", "-reindex", "-printtoconsole", "-logtimestamps=1", "-datadir=data", "-conf=../.desire/desire.conf", "-mnconf=../.desire/masternode.conf", "-port=22333", "-rpcport=22334"]
CMD ["-rpcallowip=127.0.0.1", "-server=1", "-masternode=0"]
