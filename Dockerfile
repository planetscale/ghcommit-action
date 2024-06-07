FROM ghcr.io/planetscale/ghcommit:v0.1.47@sha256:5c3e3964fcb8ecbc34fd7cfdf8e652f08a7f0c5529617d382d57368b17ed0628 AS ghcommit

FROM pscale.dev/wolfi-prod/base:latest AS base

COPY --from=ghcommit /ghcommit /usr/bin/ghcommit

RUN apk add --no-cache \
        bash \
        git

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
