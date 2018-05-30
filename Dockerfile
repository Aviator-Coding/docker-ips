FROM ubuntu:16.04

RUN apt-get update && \
    apt-get --no-install-recommends --yes install \
         git \
         automake \
         build-essential \
         libtool \
         autotools-dev \
         autoconf \
         pkg-config \
         libssl-dev \ 
         libboost-all-dev \
         libevent-dev \
         bsdmainutils \
         vim \
         software-properties-common

RUN add-apt-repository ppa:bitcoin/bitcoin && \
    apt-get update && \
    apt-get --no-install-recommends --yes install \
          libdb4.8-dev \
          libdb4.8++-dev \
          libminiupnpc-dev 

WORKDIR /ips

ENV IPS_VERSION v3.0.0.2 

RUN git clone https://github.com/ipsum-network/ips.git . && \
    git checkout $IPS_VERSION && \
    ./autogen.sh && \
    ./configure && \
    make &&\
    strip src/ipsd src/ips-cli src/ips-tx && \
    mv src/ipsd /usr/local/bin/ && \
    mv src/ips-cli /usr/local/bin/ && \
    mv src/ips-tx /usr/local/bin/ && \
    # clean
    rm -rf /ips

VOLUME ["/root/.ips"]

EXPOSE 22331

CMD /usr/local/bin/ipsd -daemon -txindex && tail -f /root/.ips/debug.log
