FROM ubuntu:22.04
LABEL maintainer="emanuele.palazzetti@gmail.com"

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
  python3 \
  python3-pip \
  tar \
&& rm -rf /var/lib/apt/lists/*

COPY . /builder
WORKDIR /builder

CMD /bin/bash bin/build.sh
