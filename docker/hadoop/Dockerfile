ARG BASE_IMAGE

FROM maven:3.6.3-jdk-11 as downloader

ARG AWS_BUNDLE_VERSION
RUN mvn dependency:get \
    -DremoteRepositores=https://repo.maven.apache.org/maven2/ -Dpackaging=jar \
    -Dartifact=com.amazonaws:aws-java-sdk-bundle:${AWS_BUNDLE_VERSION}

RUN mvn dependency:copy \
    -Dartifact=com.amazonaws:aws-java-sdk-bundle:${AWS_BUNDLE_VERSION} \
    -DoutputDirectory=/jars


FROM ${BASE_IMAGE}
ARG HADOOP_VERSION
RUN /scripts/apache/download_apache.sh hadoop ${HADOOP_VERSION} /opt/hadoop

ENV HADOOP_HOME         /opt/hadoop
ENV HADOOP_CONF_DIR     /opt/hadoop/etc/hadoop
ENV PATH                ${HADOOP_HOME}/bin:${PATH}

RUN rm -rf ${HADOOP_HOME}/share/hadoop/tools/lib/aws-java-sdk-bundle*.jar
RUN cp ${HADOOP_HOME}/share/hadoop/tools/lib/hadoop-aws-${HADOOP_VERSION}.jar \
    ${HADOOP_HOME}/share/hadoop/hdfs/lib/hadoop-aws-${HADOOP_VERSION}.jar
COPY --from=downloader /jars/*.jar ${HADOOP_HOME}/share/hadoop/hdfs/lib/
