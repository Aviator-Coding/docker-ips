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
<<<<<<< HEAD
         software-properties-common
=======
         software-properties-common && \
         rm -rf /var/lib/apt/lists/* 
>>>>>>> 6887c8a00448f621471a718b4371d310b756e58e

RUN add-apt-repository ppa:bitcoin/bitcoin && \
    apt-get update && \
    apt-get --no-install-recommends --yes install \
          libdb4.8-dev \
          libdb4.8++-dev \
<<<<<<< HEAD
          libminiupnpc-dev 
=======
          libminiupnpc-dev && \
          rm -rf /var/lib/apt/lists/* 
>>>>>>> 6887c8a00448f621471a718b4371d310b756e58e

WORKDIR /ips

ENV IPS_VERSION v3.0.0.2 

RUN git clone https://github.com/ipsum-network/ips.git . && \
    git checkout $IPS_VERSION && \
    ./autogen.sh && \
    ./configure && \
<<<<<<< HEAD
    make &&\
    strip src/ipsd src/ips-cli src/ips-tx && \
    mv src/ipsd /usr/local/bin/ && \
    mv src/ips-cli /usr/local/bin/ && \
    mv src/ips-tx /usr/local/bin/ && \
    # clean
=======
    make && \
    strip /ips/src/ipsd /ips/src/ips-cli /ips/src/ips-tx && \
    mv /ips/src/ipsd /usr/local/bin/ && \
    mv /ips/src/ips-cli /usr/local/bin/ && \
    mv /ips/src/ips-tx /usr/local/bin/ &&\
>>>>>>> 6887c8a00448f621471a718b4371d310b756e58e
    rm -rf /ips

VOLUME ["/root/.ips"]

EXPOSE 22331

<<<<<<< HEAD
CMD /usr/local/bin/ipsd -daemon -txindex && tail -f /root/.ips/debug.log
=======
CMD /usr/local/bin/ipsd && tail -f /root/.ips/debug.log
>>>>>>> 6887c8a00448f621471a718b4371d310b756e58e
