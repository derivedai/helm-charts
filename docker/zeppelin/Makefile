export ZEPPELIN_VERSION=0.9.0
export BASE_IMAGE=apache/zeppelin
export SPARK_VERSION=3.0.1
export REPO_NAME=derivedai/zeppelin
build:
	docker build --build-arg BASE_IMAGE=${BASE_IMAGE}:${ZEPPELIN_VERSION} \
				--build-arg SPARK_VERSION=${SPARK_VERSION} \
				 -f ./Dockerfile \
				 -t ${REPO_NAME}:${ZEPPELIN_VERSION}-spark${SPARK_VERSION} \
				 .
