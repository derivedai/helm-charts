SPARK_VERSION ?= 3.0.1
BASE_IMAGE ?= derivedai/hadoop
BASE_TAG ?= 3.2.1
REPO_NAME ?= derivedai/spark
HIVE_VERSION ?= 3.1.2
build:
	docker build --build-arg BASE_IMAGE=${BASE_IMAGE}:${BASE_TAG} \
				 --build-arg SPARK_VERSION=${SPARK_VERSION} \
				 --build-arg HIVE_VERSION=${HIVE_VERSION} \
				 -f ./Dockerfile \
				 -t ${REPO_NAME}:${SPARK_VERSION}-hive-${HIVE_VERSION}-hadoop-${BASE_TAG} \
				 .

push:
	docker push ${REPO_NAME}:${SPARK_VERSION}-hive-${HIVE_VERSION}-hadoop-${BASE_TAG}
	docker tag  ${REPO_NAME}:${SPARK_VERSION}-hive-${HIVE_VERSION}-hadoop-${BASE_TAG} ${REPO_NAME}:latest
	docker push ${REPO_NAME}:latest