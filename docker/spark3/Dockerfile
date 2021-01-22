FROM maven:3.6.3-jdk-11 as downloader
RUN apt update && apt install -y python3
RUN wget -c https://github.com/apache/spark/archive/v3.1.1-rc1.tar.gz \
    -O /tmp/spark.tgz
