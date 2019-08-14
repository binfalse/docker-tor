FROM alpine:latest

RUN apk update \
 && apk upgrade \
 && apk add tor \
 && rm /var/cache/apk/*

EXPOSE 9050

ADD ./torrc /etc/tor/torrc

USER tor
CMD /usr/bin/tor -f /etc/tor/torrc
