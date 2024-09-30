FROM ghcr.io/planetscale/ghcommit:v0.1.50@sha256:3c980bd814944e4baa8cc8b69415b9e2ad569776b79ea21a8bb447320a842f46 AS ghcommit

# hadolint ignore=DL3007
FROM pscale.dev/wolfi-prod/base:latest AS base

COPY --from=ghcommit /ghcommit /usr/bin/ghcommit

# hadolint ignore=DL3018
RUN apk add --no-cache \
        bash \
        git

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
