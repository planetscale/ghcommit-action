FROM ghcr.io/planetscale/ghcommit:v0.1.23@sha256:c27aab78d381e4ae8ca9915a2325eb1d002084babcdbaa8c3dcac2a7d53e418e AS ghcommit

FROM pscale.dev/wolfi-prod/base:latest@sha256:e0d90cabe07563f8145923c0ffcd7628df2d1187cce98e19abf2598bac78f8c9 AS base

COPY --from=ghcommit /ghcommit /usr/bin/ghcommit

RUN apk add --no-cache \
        bash \
        git

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
