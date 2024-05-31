FROM ghcr.io/planetscale/ghcommit:v0.1.45@sha256:a1057b140cd4cf5bf8665ab39a894c6aae8d2cbbde4ced0cd9035d121378f132 AS ghcommit

FROM pscale.dev/wolfi-prod/base:latest AS base

COPY --from=ghcommit /ghcommit /usr/bin/ghcommit

RUN apk add --no-cache \
        bash \
        git

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
