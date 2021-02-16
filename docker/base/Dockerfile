#ARG BASE_IMAGE
#FROM maven:3.6.3-jdk-11 as downloader
#
#ARG HADOOP_VERSION=3.3.0
#ARG CLOUD_VERSION=aws
#ARG AWS_BUNDLE_VERSION=1.11.939
#
#RUN mvn dependency:get \
#    -DremoteRepositores=https://repo.maven.apache.org/maven2/ -Dpackaging=jar \
#    -Dartifact=org.apache.hadoop:hadoop-${CLOUD_VERSION}:${HADOOP_VERSION}
#RUN mkdir -p /jars
#
#RUN mvn dependency:copy-dependencies \
#    -f ${HOME}/.m2/repository/org/apache/hadoop/hadoop-${CLOUD_VERSION}/${HADOOP_VERSION}/hadoop-${CLOUD_VERSION}-${HADOOP_VERSION}.pom \
#    -DoutputDirectory=/jars
#
#RUN mvn dependency:copy \
#    -Dartifact=org.apache.hadoop:hadoop-${CLOUD_VERSION}:${HADOOP_VERSION} \
#    -DoutputDirectory=/jars
#
#RUN rm -rf /jars/aws-java-sdk-bundle-*.jar
#
#RUN mvn dependency:get \
#    -DremoteRepositores=https://repo.maven.apache.org/maven2/ -Dpackaging=jar \
#    -Dartifact=com.amazonaws:aws-java-sdk-bundle:${AWS_BUNDLE_VERSION}
#
#RUN mvn dependency:copy \
#    -Dartifact=com.amazonaws:aws-java-sdk-bundle:${AWS_BUNDLE_VERSION} \
#    -DoutputDirectory=/jars
ARG BASE_IMAGE
FROM ${BASE_IMAGE}
RUN apt update && apt install -y wget gnupg procps

# Install Java
ARG ZULU_JAVA_VERSION
RUN mkdir -p /usr/share/man/man1
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0xB1998361219BD9C9 && \
    wget -c https://cdn.azul.com/zulu/bin/zulu-repo_1.0.0-2_all.deb \
    -O /tmp/zulu-repo.deb && \
    apt install -y /tmp/zulu-repo.deb && \
    apt update && \
    rm -rf /tmp/zulu-repo.deb && \
    apt install -y zulu${ZULU_JAVA_VERSION}

# Set JAVA_HOME
ENV JAVA_HOME   /usr/lib/jvm/zulu${ZULU_JAVA_VERSION}

# COPY --from=downloader /jars /usr/share/java/hadoop

COPY scripts/ /scripts/apache/
RUN chmod u+x /scripts/apache/download_apache.sh