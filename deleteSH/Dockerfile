FROM alpine:3.14

RUN apk add --no-cache curl
RUN apk add --no-cache jq

WORKDIR /
COPY delete_ps.sh delete_ps.sh
RUN chmod +x /delete_ps.sh
ENTRYPOINT ["/delete_ps.sh"]
