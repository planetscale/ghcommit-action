FROM ghcr.io/planetscale/ghcommit:v0.1.43@sha256:1120c818f3a7abf23dfd2214f06dd57c71f3d3e1f74611867d917bfc4acdbd33 AS ghcommit

FROM pscale.dev/wolfi-prod/base:latest AS base

COPY --from=ghcommit /ghcommit /usr/bin/ghcommit

RUN apk add --no-cache \
        bash \
        git

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
