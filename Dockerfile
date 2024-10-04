FROM ghcr.io/planetscale/ghcommit:v0.1.51@sha256:eb0fa7df39e99d74cb14adf98b9d255eeef45577698eadc6eef546f278256eb1 AS ghcommit

# hadolint ignore=DL3007
FROM pscale.dev/wolfi-prod/base:latest AS base

COPY --from=ghcommit /ghcommit /usr/bin/ghcommit

# hadolint ignore=DL3018
RUN apk add --no-cache \
        bash \
        git

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
