FROM ghcr.io/planetscale/ghcommit:v0.0.8 AS ghcommit

FROM alpine:3.17 AS base

COPY --from=ghcommit /ghcommit /usr/bin/ghcommit

RUN apk add --no-cache \
        bash \
        git

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]