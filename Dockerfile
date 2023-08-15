FROM ghcr.io/planetscale/ghcommit:v0.1.7 AS ghcommit

FROM public.ecr.aws/docker/library/alpine:3.18 AS base

COPY --from=ghcommit /ghcommit /usr/bin/ghcommit

RUN apk add --no-cache \
        bash \
        git

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
