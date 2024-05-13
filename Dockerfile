FROM ghcr.io/planetscale/ghcommit:v0.1.42@sha256:6e082798f93210ceba1d5995da637ad20161d88604fdb511e9d959948807186d AS ghcommit

FROM pscale.dev/wolfi-prod/base:latest AS base

COPY --from=ghcommit /ghcommit /usr/bin/ghcommit

RUN apk add --no-cache \
        bash \
        git

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
