
FROM nginx:1.28-alpine

ARG BUILD_SHA=local-build

USER root

RUN apk add --no-cache curl=8014.1-r2 \
    && sed -i 's#pid[[:space:]]*/run/nginx.pid;#pid /tmp/nginx.pid;#' /etc/nginx/nginx.conf \
    && sed -i 's/^user[[:space:]]\+nginx;/# user directive removed for non-root operation/' /etc/nginx/nginx.conf \
    && mkdir -p /var/cache/nginx /var/run \
    && chown -R nginx:nginx /var/cache/nginx /var/run /usr/share/nginx/html

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY index.html /usr/share/nginx/html/index.html

RUN printf '{"build_sha":"%s"}\n' "$BUILD_SHA" > /usr/share/nginx/html/build.json \
    && chown -R nginx:nginx /usr/share/nginx/html

USER nginx

EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD curl -fsS http://127.0.0.1:8080/healthz || exit 1

