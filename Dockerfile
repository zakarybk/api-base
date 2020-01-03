FROM judge0/api-base:1.0.0-template

RUN set -xe && \
    apt-get update && \
    apt-get install -y --no-install-recommends git cron && \
    cd /usr/local && \
    git clone https://github.com/vlang/v && \
    cd v && \
    make && \
    echo "0 * * * * /usr/local/v/v up > /var/log/cron.log 2>&1" | crontab - && \
    rm -rf /var/lib/apt/lists/*

COPY entrypoint /
ENTRYPOINT ["/entrypoint"]

LABEL maintainer="Herman Zvonimir Došilović <hermanz.dosilovic@gmail.com>"
LABEL version="vlang-latest"
