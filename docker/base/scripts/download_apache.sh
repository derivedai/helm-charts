
export APACHE_MIRROR_BASE="https://www.apache.org/dyn/mirrors/mirrors.cgi?action=download&filename="
TMP_DIR=/tmp

function download_hadoop() {
  HADOOP_VERSION=$1
  echo "Downloading Hadoop ${HADOOP_VERSION}"
  wget -c ${APACHE_MIRROR_BASE}hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz \
       -O ${TMP_DIR}/hadoop-${HADOOP_VERSION}.tgz
  tar -zxf ${TMP_DIR}/hadoop-${HADOOP_VERSION}.tgz --directory /opt
  rm -rf ${TMP_DIR}/hadoop-${HADOOP_VERSION}.tgz
}

download_hadoop "$@"