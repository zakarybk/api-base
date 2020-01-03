FROM judge0/api-base:1.0.0-template

COPY update /
RUN set -xe && \
    apt-get update && \
    apt-get install -y --no-install-recommends cron && \
    /update && \
    echo "0 0 * * * /update > /var/log/cron.log 2>&1" | crontab - && \
    rm -rf /var/lib/apt/lists/*

COPY entrypoint /
ENTRYPOINT ["/entrypoint"]

LABEL maintainer="Herman Zvonimir Došilović <hermanz.dosilovic@gmail.com>"
LABEL version="nim-latest"
