ZEPPELIN_VERSION ?= 0.9.0
BASE_IMAGE ?= derivedai/spark
BASE_TAG ?= 3.0.1-hadoop-3.3.0
SPARK_VERSION ?= 3.0.1
REPO_NAME ?= derivedai/zeppelin
build:
	docker build --build-arg BASE_IMAGE=${BASE_IMAGE}:${BASE_TAG} \
				 --build-arg ZEPPELIN_VERSION=${ZEPPELIN_VERSION} \
				 -f ./Dockerfile \
				 -t ${REPO_NAME}:${ZEPPELIN_VERSION}-spark-${BASE_TAG} \
				 .

push:
	docker push ${REPO_NAME}:${ZEPPELIN_VERSION}-spark-${BASE_TAG}