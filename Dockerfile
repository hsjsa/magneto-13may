FROM ghcr.io/hsjsa/dockerbase:latest 
RUN apt-get -qq install -y snapd
RUN snap install aria2c
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
