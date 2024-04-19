FROM ghcr.io/planetscale/ghcommit:v0.1.38@sha256:5d7309b97db99dd143e616cb308bd78035d4c5e854837d6af99c59f717ded888 AS ghcommit

FROM pscale.dev/wolfi-prod/base:latest AS base

COPY --from=ghcommit /ghcommit /usr/bin/ghcommit

RUN apk add --no-cache \
        bash \
        git

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
