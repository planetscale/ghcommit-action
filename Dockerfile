FROM ghcr.io/planetscale/ghcommit:v0.1.34@sha256:f994e603f3402c1746e7ca55db9153cc1e25cf13c2dfc32056dd25fdc09ec94b AS ghcommit

FROM pscale.dev/wolfi-prod/base:latest AS base

COPY --from=ghcommit /ghcommit /usr/bin/ghcommit

RUN apk add --no-cache \
        bash \
        git

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
