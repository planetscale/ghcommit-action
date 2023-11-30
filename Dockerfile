FROM ghcr.io/planetscale/ghcommit:v0.1.16@sha256:01f932350dcbc96dfac18f34305683d3c2db5e46a92a25d3f7f5897eb6796d6c AS ghcommit

FROM pscale.dev/wolfi-prod/base:latest@sha256:e0d90cabe07563f8145923c0ffcd7628df2d1187cce98e19abf2598bac78f8c9 AS base

COPY --from=ghcommit /ghcommit /usr/bin/ghcommit

RUN apk add --no-cache \
        bash \
        git

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
