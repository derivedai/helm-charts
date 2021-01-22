SPARK_VERSION ?= 3.0.1
BASE_IMAGE ?= derivedai/hadoop
BASE_TAG ?= 3.3.0
REPO_NAME ?= derivedai/spark

build:
	docker build --build-arg BASE_IMAGE=${BASE_IMAGE}:${BASE_TAG} \
				 --build-arg SPARK_VERSION=${SPARK_VERSION} \
				 -f ./Dockerfile \
				 -t ${REPO_NAME}:${SPARK_VERSION}-hadoop-${BASE_TAG} \
				 .

push:
	docker push ${REPO_NAME}:${SPARK_VERSION}-hadoop-${BASE_TAG}