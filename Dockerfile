FROM ghcr.io/planetscale/ghcommit:v0.1.35@sha256:4c8c00f1c43462cfb3d2b584010aa46d25a1a33310107beb45c75dcd7e7de741 AS ghcommit

FROM pscale.dev/wolfi-prod/base:latest AS base

COPY --from=ghcommit /ghcommit /usr/bin/ghcommit

RUN apk add --no-cache \
        bash \
        git

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
