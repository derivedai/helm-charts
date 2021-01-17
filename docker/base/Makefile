BASE_IMAGE ?= continuumio/miniconda3
BASE_TAG ?= 4.7.12
REPO_NAME ?= derivedai/base
JAVA_VERSION ?= 8
build:
	docker build --build-arg BASE_IMAGE=${BASE_IMAGE}:${BASE_TAG} \
				 --build-arg JAVA_VERSION=${JAVA_VERSION} \
				 -f ./Dockerfile \
				 -t ${REPO_NAME}:java-${JAVA_VERSION} \
				 .

