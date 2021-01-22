ARG BASE_IMAGE
FROM ${BASE_IMAGE}
ARG HADOOP_VERSION
RUN /scripts/apache/download_apache.sh hadoop ${HADOOP_VERSION} /opt/hadoop

ENV HADOOP_HOME         /opt/hadoop
ENV HADOOP_CONF_DIR     /opt/hadoop/etc/hadoop
ENV PATH                ${HADOOP_HOME}/bin:${PATH}

RUN rm -rf ${HADOOP_HOME}/share/hadoop/tools/lib/aws-java-sdk-bundle*.jar
RUN cp ${HADOOP_HOME}/share/hadoop/tools/lib/hadoop-aws-${HADOOP_VERSION}.jar \
    ${HADOOP_HOME}/share/hadoop/hdfs/lib/hadoop-aws-${HADOOP_VERSION}.jar

ARG AWS_BUNDLE_VERSION
RUN wget -c https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/${AWS_BUNDLE_VERSION}/aws-java-sdk-bundle-${AWS_BUNDLE_VERSION}.jar \
         -O ${HADOOP_HOME}/share/hadoop/hdfs/lib/aws-java-sdk-bundle-${AWS_BUNDLE_VERSION}.jar
