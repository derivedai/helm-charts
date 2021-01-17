BASE_IMAGE ?= continuumio/miniconda3
BASE_TAG ?= 4.7.12
REGISTRY ?= ""
REPO_NAME ?= derivedai/base
JAVA_VERSION ?= 8
HADOOP_VERSION ?= 3.2.1
build:
	docker build --build-arg BASE_IMAGE=${BASE_IMAGE}:${BASE_TAG} \
				 --build-arg ZULU_JAVA_VERSION=${JAVA_VERSION} \
				 -f ./Dockerfile \
				 -t ${REPO_NAME}:java-8 \
				 .

push:
	docker push ${REPO_NAME}:java-8