FROM alpine:latest

RUN apk update && apk add --no-cache bash apcupsd curl ucspi-tcp

COPY entrypoint.sh .
COPY apcupsd.conf /etc/apcupsd/apcupsd.conf
COPY eventscriptoverrides /etc/apcupsd/tmpscripts
COPY nut-wrapper.sh /etc/apcupsd/nut-wrapper.sh

RUN chmod -R 744 /etc/apcupsd/tmpscripts/
RUN mv -v /etc/apcupsd/tmpscripts/* /etc/apcupsd
RUN rm -rf /etc/apcupsd/tmpscripts

CMD [ "bash", "entrypoint.sh" ]