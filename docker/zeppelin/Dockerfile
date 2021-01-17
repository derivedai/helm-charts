ARG BASE_IMAGE
FROM ${BASE_IMAGE}

# Set user to root to install dependencies
USER root

# Install Spark
ARG SPARK_VERSION
ARG HADOOP_VERSION=hadoop3.2
ARG APACHE_MIRROR_BASE="https://www.apache.org/dyn/mirrors/mirrors.cgi?action=download&filename="
RUN wget -c ${APACHE_MIRROR_BASE}spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-${HADOOP_VERSION}.tgz \
    -O /tmp/spark-${SPARK_VERSION}-bin-${HADOOP_VERSION}.tgz \
    --verbose && \
    tar -zxf /tmp/spark-${SPARK_VERSION}-bin-${HADOOP_VERSION}.tgz \
    --directory /opt && \
    rm -rf /tmp/spark-${SPARK_VERSION}-bin-${HADOOP_VERSION}.tgz

ENV SPARK_HOME  /opt/spark-${SPARK_VERSION}-bin-${HADOOP_VERSION}
ENV PATH        ${SPARK_HOME}/bin:${PATH}

ENTRYPOINT ["/bin/bash"]