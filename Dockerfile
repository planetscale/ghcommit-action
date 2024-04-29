FROM ghcr.io/planetscale/ghcommit:v0.1.40@sha256:2b29f3e8dcf3712e614e3b7afbd7dc99eb11d9fbd0371dac1f39860ff7da5184 AS ghcommit

FROM pscale.dev/wolfi-prod/base:latest AS base

COPY --from=ghcommit /ghcommit /usr/bin/ghcommit

RUN apk add --no-cache \
        bash \
        git

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
