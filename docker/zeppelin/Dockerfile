ARG BASE_IMAGE
FROM ${BASE_IMAGE}

ARG ZEPPELIN_VERSION
RUN /scripts/apache/download_apache.sh zeppelin ${ZEPPELIN_VERSION}
ENV ZEPPELIN_HOME  /opt/zeppelin
ENV PATH        ${ZEPPELIN_HOME}/bin:${PATH}
COPY config/hive-site.xml /opt/spark/conf/hive-site.xml

ENTRYPOINT ["/bin/bash"]