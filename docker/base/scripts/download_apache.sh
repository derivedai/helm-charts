
APACHE_MIRROR_BASE="https://archive.apache.org/dist/"
TMP_DIR=/tmp

download_package() {
  PACKAGE_URL_PREFIX=$1
  PACKAGE_FILENAME=$2
  OUT_DIR=$3
  wget -c ${APACHE_MIRROR_BASE}${PACKAGE_URL_PREFIX}/${PACKAGE_FILENAME} -O ${TMP_DIR}/${PACKAGE_FILENAME}
  mkdir -p ${OUT_DIR}
  tar -zxf ${TMP_DIR}/${PACKAGE_FILENAME} --directory ${OUT_DIR} --strip-components=1
  rm -rf ${TMP_DIR:-}/${PACKAGE_FILENAME:-}
}
download_hadoop() {
  HADOOP_VERSION=$1
  echo "Downloading Hadoop ${HADOOP_VERSION}"
  download_package hadoop/common/hadoop-${HADOOP_VERSION} hadoop-${HADOOP_VERSION}.tar.gz /opt/hadoop
}

download_spark() {
  SPARK_VERSION=$1
  HADOOP_VERSION=$2
  echo "Downloading Spark ${SPARK_VERSION}"
  download_package "spark/spark-${SPARK_VERSION}" "spark-${SPARK_VERSION}-bin-${HADOOP_VERSION}.tgz" /opt/spark
}

download_hive() {
  HIVE_VERSION=$1
  echo "Downloading Hive ${HIVE_VERSION}"
  download_package "hive/hive-${HIVE_VERSION}" "apache-hive-${HIVE_VERSION}-bin-tar.gz" /opt/hive
}

download_metastore() {
  METASTORE_VERSION=$1
  echo "Downloading Hive Metastore ${METASTORE_VERSION}"
  download_package "hive/hive-standalone-metastore-${METASTORE_VERSION}" "hive-standalone-metastore-${METASTORE_VERSION}-bin.tar.gz" /opt/hive-metastore
}

download_zeppelin(){
  ZEPPELIN_VERSION=$1
  echo "Downloading Apache Zeppelin ${ZEPPELIN_VERSION}"
  download_package "zeppelin/zeppelin-${ZEPPELIN_VERSION}" "zeppelin-${ZEPPELIN_VERSION}-bin-all.tgz" /opt/zeppelin
}

install_package() {
  APACHE_PACKAGE=$1
  shift
  case $APACHE_PACKAGE in
    hadoop)
      download_hadoop $@
      ;;
    spark)
      download_spark $@
      ;;
    metastore)
      download_metastore $@
      ;;
    zeppelin)
      download_zeppelin $@
      ;;
  esac
}

install_package "$@"
