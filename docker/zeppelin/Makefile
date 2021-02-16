ZEPPELIN_VERSION ?= 0.9.0
BASE_IMAGE ?= derivedai/spark
BASE_TAG ?= 3.0.1-hive-3.1.2-hadoop-3.2.1
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
	docker tag ${REPO_NAME}:${ZEPPELIN_VERSION}-spark-${BASE_TAG} ${REPO_NAME}:latest
	docker push ${REPO_NAME}:latest


build-interpreter:
	docker build --build-arg BASE_IMAGE=${REPO_NAME}:${ZEPPELIN_VERSION}-spark-${BASE_TAG} \
				 --build-arg ZEPPELIN_VERSION=${ZEPPELIN_VERSION} \
				 -f ./Dockerfile.interpreter \
				 -t  ${REPO_NAME}:${ZEPPELIN_VERSION}-spark-${BASE_TAG}-interpreter \
				 .

push-interpreter:
    docker push ${REPO_NAME}:${ZEPPELIN_VERSION}-spark-${BASE_TAG}-interpreter