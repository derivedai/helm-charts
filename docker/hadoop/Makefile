BASE_IMAGE ?= derivedai/base
BASE_TAG ?= java-8
REPO_NAME ?= derivedai/hadoop
HADOOP_VERSION ?= 3.2.1
AWS_BUNDLE_VERSION ?= 1.11.939

build:
	docker build --build-arg BASE_IMAGE=${BASE_IMAGE}:${BASE_TAG} \
				 --build-arg HADOOP_VERSION=${HADOOP_VERSION} \
				 --build-arg AWS_BUNDLE_VERSION=${AWS_BUNDLE_VERSION} \
				 -f ./Dockerfile \
				 -t ${REPO_NAME}:${HADOOP_VERSION} \
				 .

push:
	docker push ${REPO_NAME}:${HADOOP_VERSION}