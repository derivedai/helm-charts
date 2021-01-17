ARG BASE_IMAGE
FROM ${BASE_IMAGE}

RUN apt update && apt install -y wget gnupg procps

# Install Java
ARG JAVA_VERSION
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0xB1998361219BD9C9 && \
    wget -c https://cdn.azul.com/zulu/bin/zulu-repo_1.0.0-2_all.deb \
    -O /tmp/zulu-repo.deb && \
    apt install -y /tmp/zulu-repo.deb && \
    apt update && \
    rm -rf /tmp/zulu-repo.deb && \
    apt install -y zulu${JAVA_VERSION}-jre-headless

# Set JAVA_HOME
ENV JAVA_HOME   /usr/lib/jvm/zulu${JAVA_VERSION}/jre

COPY scripts/ /scripts/apache/
RUN chmod u+x /scripts/apache/download_apache.sh