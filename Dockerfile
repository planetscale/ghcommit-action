FROM ghcr.io/planetscale/ghcommit:v0.1.23@sha256:c27aab78d381e4ae8ca9915a2325eb1d002084babcdbaa8c3dcac2a7d53e418e AS ghcommit

FROM pscale.dev/wolfi-prod/base:latest@sha256:1cdca1ed642d5b3a61741afbf7e568f2ad437a150eb428df903a777290203663 AS base

COPY --from=ghcommit /ghcommit /usr/bin/ghcommit

RUN apk add --no-cache \
        bash \
        git

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
