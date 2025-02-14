FROM alpine:3.18 AS builder

RUN apk add build-base autoconf automake libtool pkgconf git
COPY . /xinetd
RUN cd xinetd && sh ./autogen.sh && ./configure && make

FROM alpine:latest

COPY --from=builder /xinetd/xinetd /usr/sbin
RUN mkdir -p /etc/xinetd.d/

CMD ["sleep", "infinity"]
