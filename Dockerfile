FROM ubuntu:22.04

WORKDIR /usr/src/app
RUN chmod 777 /usr/src/app
RUN apt-get -qq update && \
    DEBIAN_FRONTEND="noninteractive" apt-get -qq install -y tzdata wget unzip git python3 python3-pip \
    locales python3-lxml \
    curl pv jq ffmpeg \
    p7zip-full p7zip-rar \
    libcrypto++-dev libssl-dev \
    libc-ares-dev libcurl4-openssl-dev \
    libsqlite3-dev libsodium-dev && \
    curl -L https://github.com/jaskaranSM/megasdkrest/releases/download/v0.1/megasdkrest -o /usr/local/bin/megasdkrest && \
    chmod +x /usr/local/bin/megasdkrest
RUN apt-get -qq install -y libcppunit-dev
RUN apt-get -qq install -y libxml2-dev
RUN apt-get -qq install -y autoconf
RUN apt-get -qq install -y automake
RUN apt-get -qq install -y autotools-dev
RUN apt-get -qq install -y autopoint
RUN apt-get -qq install -y libtool    
RUN wget https://mirror.root-gamr.workers.dev/0:/aria2-1.30.0.zip
RUN unzip aria2-1.30.0.zip .
RUN chmod +x configure
RUN ./configure
RUN make
COPY requirements.txt .
COPY extract /usr/local/bin
COPY pextract /usr/local/bin
RUN chmod +x /usr/local/bin/extract && chmod +x /usr/local/bin/pextract
RUN pip3 install --no-cache-dir -r requirements.txt
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
COPY . .
COPY netrc /root/.netrc
RUN chmod +x aria.sh
CMD ["bash","start.sh"]
