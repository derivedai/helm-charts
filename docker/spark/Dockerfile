ARG BASE_IMAGE
FROM maven:3.6.3-jdk-8 as downloader
ARG HIVE_VERSION

RUN mkdir -p /jars
RUN mkdir -p /hivejars

ARG SPARK_VERSION
RUN mvn dependency:get \
    -DremoteRepositores=https://repo.maven.apache.org/maven2/ -Dpackaging=jar \
    -Dartifact=org.apache.spark:spark-hive_2.12:${SPARK_VERSION} && \
    mvn dependency:copy-dependencies \
        -f ${HOME}/.m2/repository/org/apache/spark/spark-hive_2.12/${SPARK_VERSION}/spark-hive_2.12-${SPARK_VERSION}.pom \
        -DoutputDirectory=/jars && \
    mvn dependency:copy \
    -Dartifact=org.apache.spark:spark-hive_2.12:${SPARK_VERSION} \
    -DoutputDirectory=/jars


RUN mvn dependency:get \
    -DremoteRepositores=https://repo.maven.apache.org/maven2/ -Dpackaging=jar \
    -Dartifact=org.apache.hive:hive-common:${HIVE_VERSION} && \
    mvn dependency:copy-dependencies \
        -f ${HOME}/.m2/repository/org/apache/hive/hive-common/${HIVE_VERSION}/hive-common-${HIVE_VERSION}.pom\
        -DoutputDirectory=/hivejars && \
    mvn dependency:copy \
        -Dartifact=org.apache.hive:hive-common:${HIVE_VERSION} \
        -DoutputDirectory=/hivejars

RUN mvn dependency:get \
    -DremoteRepositores=https://repo.maven.apache.org/maven2/ -Dpackaging=jar \
    -Dartifact=org.apache.hive:hive-metastore:${HIVE_VERSION} && \
    mvn dependency:copy-dependencies \
        -f ${HOME}/.m2/repository/org/apache/hive/hive-metastore/${HIVE_VERSION}/hive-metastore-${HIVE_VERSION}.pom\
        -DoutputDirectory=/hivejars && \
    mvn dependency:copy \
        -Dartifact=org.apache.hive:hive-metastore:${HIVE_VERSION} \
        -DoutputDirectory=/hivejars

RUN mvn dependency:get \
    -DremoteRepositores=https://repo.maven.apache.org/maven2/ -Dpackaging=jar \
    -Dartifact=org.apache.hive:hive-exec:${HIVE_VERSION} && \
    mvn dependency:copy-dependencies \
        -f ${HOME}/.m2/repository/org/apache/hive/hive-exec/${HIVE_VERSION}/hive-exec-${HIVE_VERSION}.pom\
        -DoutputDirectory=/hivejars && \
    mvn dependency:copy \
        -Dartifact=org.apache.hive:hive-exec:${HIVE_VERSION} \
        -DoutputDirectory=/hivejars


FROM ${BASE_IMAGE}

ARG SPARK_VERSION
RUN /scripts/apache/download_apache.sh spark ${SPARK_VERSION} without-hadoop

ENV SPARK_HOME      /opt/spark
ENV PATH            ${SPARK_HOME}/bin:${PATH}
RUN sed 's/set -ex/set -ex\nexport SPARK_DIST_CLASSPATH=$(hadoop classpath)/g' /opt/spark/kubernetes/dockerfiles/spark/entrypoint.sh > /opt/entrypoint.sh && \
    chmod +x /opt/entrypoint.sh
RUN apt install -y tini
COPY scripts/spark-env.sh /opt/spark/conf/spark-env.sh
RUN chmod +x /opt/spark/conf/spark-env.sh

RUN wget -c https://repo1.maven.org/maven2/org/apache/hudi/hudi-spark-bundle_2.12/0.7.0/hudi-spark-bundle_2.12-0.7.0.jar \
         -O /opt/spark/jars/hudi-spark-bundle_2.12-0.7.0.jar
RUN wget -c https://repo1.maven.org/maven2/io/delta/delta-core_2.12/0.8.0/delta-core_2.12-0.8.0.jar \
         -O /opt/spark/jars/delta-core_2.12-0.8.0.jar
RUN wget -c https://repo1.maven.org/maven2/org/apache/iceberg/iceberg-spark3-runtime/0.11.0/iceberg-spark3-runtime-0.11.0.jar \
         -O /opt/spark/jars/iceberg-spark3-runtime-0.11.0.jar

RUN mkdir -p /usr/local/share/jars/hive

ARG HIVE_VERSION
RUN  wget -c https://repo1.maven.org/maven2/org/apache/spark/spark-hive_2.12/${SPARK_VERSION}/spark-hive_2.12-${SPARK_VERSION}.jar \
                -O /opt/spark/jars/spark-hive_2.12-${SPARK_VERSION}.jar

COPY --from=downloader /jars/* /opt/spark/jars/
RUN rm -rf /opt/spark/jars/hadoop*.jar
RUN mkdir -p /usr/local/share/jars/hive/
COPY --from=downloader /hivejars/* /usr/local/share/jars/hive/
RUN pip install -e $SPARK_HOME/python

ENTRYPOINT ["/opt/entrypoint.sh"]
