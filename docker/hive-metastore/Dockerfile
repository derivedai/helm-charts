ARG BASE_IMAGE
FROM maven:3.6.3-jdk-11 as downloader

ARG POSTGRESQL_JDBC_VERSION=42.2.18
RUN mvn dependency:get \
    -DremoteRepositores=https://repo.maven.apache.org/maven2/ -Dpackaging=jar \
    -Dartifact=org.postgresql:postgresql:${POSTGRESQL_JDBC_VERSION}

RUN mvn dependency:copy \
    -Dartifact=org.postgresql:postgresql:${POSTGRESQL_JDBC_VERSION} \
    -DoutputDirectory=/jars


FROM ${BASE_IMAGE}
ARG METASTORE_VERSION
RUN /scripts/apache/download_apache.sh metastore ${METASTORE_VERSION} /opt/hive-metastore
ENV HIVE_HOME           /opt/hive-metastore
ENV PATH                ${HIVE_HOME}/bin:${PATH}

COPY --from=downloader /jars/*.jar ${HIVE_HOME}/lib/