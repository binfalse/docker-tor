FROM alpine:latest

RUN apk update \
 && apk upgrade \
 && apk add tor \
 && rm /var/cache/apk/* \
 && chmod 700 /var/lib/tor

EXPOSE 9050

ADD ./torrc /etc/tor/torrc
ADD startscript.sh /startscript.sh

CMD /startscript.sh
