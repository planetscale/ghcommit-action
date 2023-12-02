FROM ghcr.io/planetscale/ghcommit:v0.1.22@sha256:7f872f2d1254dc529b19cb8690d3e37f0bdf6ee1a023f98271a84f2c00aca358 AS ghcommit

FROM pscale.dev/wolfi-prod/base:latest@sha256:e0d90cabe07563f8145923c0ffcd7628df2d1187cce98e19abf2598bac78f8c9 AS base

COPY --from=ghcommit /ghcommit /usr/bin/ghcommit

RUN apk add --no-cache \
        bash \
        git

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
