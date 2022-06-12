FROM docker.io/library/golang:1.17.11-buster AS builder
RUN apt-get update -qq \
 && DEBIAN_FRONTEND=noninteractive apt-get install -qqy git \
 && mkdir /build

WORKDIR /build
RUN git clone --depth 1 --branch v0.2.6 https://github.com/solo-io/packer-plugin-arm-image /build
RUN go build -o packer-plugin-arm-image

FROM docker.io/library/ubuntu:focal

RUN apt-get update -qq \
 && DEBIAN_FRONTEND=noninteractive apt-get install -qqy \
  qemu-user-static \
  unzip \
  wget \
  sudo \
 && rm -rf /var/lib/apt/lists/*

ENV PACKER_VERSION 1.8.1

RUN wget https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip -O /tmp/packer.zip \
 && unzip /tmp/packer.zip -d /bin \
 && rm /tmp/packer.zip
WORKDIR /build

COPY --from=builder /build/packer-plugin-arm-image /bin/packer-plugin-arm-image
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
