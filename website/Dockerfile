# syntax=docker/dockerfile:1

FROM --platform=$BUILDPLATFORM node:22-alpine AS build
WORKDIR /app/website
ARG SITE_URL=https://echoesmusic.app/
ENV SITE_URL=${SITE_URL}
COPY build.mjs index.html styles.css script.js _headers ./
COPY en/ ./en/
COPY assets/ ./assets/
RUN node build.mjs

FROM nginxinc/nginx-unprivileged:stable-alpine
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=build --chown=101:101 /app/website/dist/ /usr/share/nginx/html/
EXPOSE 8080
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD wget -q -O /dev/null http://127.0.0.1:8080/healthz || exit 1
USER 101:101
RUN nginx -t
ENTRYPOINT ["nginx"]
CMD ["-g", "daemon off;"]
