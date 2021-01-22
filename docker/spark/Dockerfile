ARG BASE_IMAGE
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
ENTRYPOINT ["/opt/entrypoint.sh"]



