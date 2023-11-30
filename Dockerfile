FROM ghcr.io/planetscale/ghcommit:v0.1.19@sha256:b1cfef367ebd5ccad4d15894801930fb359c614c42bcf1e160bf7380d5594a0c AS ghcommit

FROM pscale.dev/wolfi-prod/base:latest@sha256:e0d90cabe07563f8145923c0ffcd7628df2d1187cce98e19abf2598bac78f8c9 AS base

COPY --from=ghcommit /ghcommit /usr/bin/ghcommit

RUN apk add --no-cache \
        bash \
        git

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
