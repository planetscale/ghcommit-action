FROM ghcr.io/planetscale/ghcommit:v0.1.23@sha256:c27aab78d381e4ae8ca9915a2325eb1d002084babcdbaa8c3dcac2a7d53e418e AS ghcommit

FROM pscale.dev/wolfi-prod/base:latest@sha256:8261568a0901a94c35c4ffbf1808d81194aac6fea3ab61896ee570b62bccef2d AS base

COPY --from=ghcommit /ghcommit /usr/bin/ghcommit

RUN apk add --no-cache \
        bash \
        git

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
