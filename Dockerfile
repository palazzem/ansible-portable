FROM archlinux/base
LABEL maintainer="hello@palazzetti.me"

RUN pacman --noconfirm -Sy \
  python \
  python-pip \
  tar

COPY . /builder
WORKDIR /builder

CMD /bin/bash build.sh
