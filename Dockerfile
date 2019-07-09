FROM judge0/buildpack-deps:stretch-2019-06-19

ENV RUBY_VERSIONS \
      2.6.3
RUN set -xe && \
    for RUBY_VERSION in $RUBY_VERSIONS; do \
      curl -fSsL "https://cache.ruby-lang.org/pub/ruby/${RUBY_VERSION%.*}/ruby-$RUBY_VERSION.tar.gz" -o /tmp/ruby-$RUBY_VERSION.tar.gz && \
      mkdir /tmp/ruby-$RUBY_VERSION && \
      tar -xf /tmp/ruby-$RUBY_VERSION.tar.gz -C /tmp/ruby-$RUBY_VERSION --strip-components=1 && \
      rm /tmp/ruby-$RUBY_VERSION.tar.gz && \
      cd /tmp/ruby-$RUBY_VERSION && \
      ./configure \
        --disable-install-doc \
        --prefix=/usr/local/ruby-$RUBY_VERSION && \
      make -j$(nproc) && \
      make -j$(nproc) install && \
      rm -rf /tmp/ruby-$RUBY_VERSION; \
    done

RUN set -xe && \
    curl -fSsL "https://download.java.net/java/GA/jdk12.0.1/69cfe15208a647278a19ef0990eea691/12/GPL/openjdk-12.0.1_linux-x64_bin.tar.gz" -o /tmp/openjdk12.tar.gz && \
    mkdir /usr/local/openjdk12 && \
    tar -xf /tmp/openjdk12.tar.gz -C /usr/local/openjdk12 --strip-components=1 && \
    rm /tmp/openjdk12.tar.gz && \
    ln -s /usr/local/openjdk12/bin/javac /usr/local/bin/javac && \
    ln -s /usr/local/openjdk12/bin/java /usr/local/bin/java && \
    ln -s /usr/local/openjdk12/bin/jar /usr/local/bin/jar && \
    mkdir /usr/local/junit-4.12 /usr/local/hamcrest-2.1 /usr/local/junit-platform-console-standalone-1.5.0 && \
    curl -fSsL "https://search.maven.org/remotecontent?filepath=junit/junit/4.12/junit-4.12.jar" -o /usr/local/junit-4.12/junit-4.12.jar && \
    curl -fSsL "https://search.maven.org/remotecontent?filepath=org/hamcrest/hamcrest/2.1/hamcrest-2.1.jar" -o /usr/local/hamcrest-2.1/hamcrest-2.1.jar && \ 
    curl -fSsL "https://repo1.maven.org/maven2/org/junit/platform/junit-platform-console-standalone/1.5.0/junit-platform-console-standalone-1.5.0.jar" \
      -o /usr/local/junit-platform-console-standalone-1.5.0/junit-platform-console-standalone-1.5.0.jar

RUN set -xe && \
    apt-get update && \
    apt-get install -y locales && \
    rm -rf /var/lib/apt/lists/* && \
    echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen
ENV LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8

RUN set -xe && \
    apt-get update && \
    apt-get install -y libcap-dev && \
    rm -rf /var/lib/apt/lists/* && \
    git clone https://github.com/ioi/isolate.git /tmp/isolate && \
    cd /tmp/isolate && \
    git checkout 18554e83793508acd1032d0cf4229a332c43085e && \
    echo "num_boxes = 2147483647" >> default.cf && \
    make -j$(nproc) install && \
    rm -rf /tmp/isolate
ENV BOX_ROOT /var/local/lib/isolate

LABEL maintainer="Herman Zvonimir Došilović, hermanz.dosilovic@gmail.com"
LABEL version="junit"
