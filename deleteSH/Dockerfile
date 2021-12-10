FROM ubuntu:3.14

RUN apk update && apk add --no-cache bash && apk add --no-cache curl && apk add --no-cache jq

WORKDIR /
COPY delete_ps.sh delete_ps.sh
RUN chmod +x /delete_ps.sh
ENTRYPOINT ["/delete_ps.sh"]
