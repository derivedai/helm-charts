METASTORE_VERSION ?= 3.0.0
BASE_IMAGE ?= derivedai/hadoop
BASE_TAG ?= 3.3.0
REPO_NAME ?= derivedai/hive-metastore

build:
	docker build --build-arg BASE_IMAGE=${BASE_IMAGE}:${BASE_TAG} \
				 --build-arg METASTORE_VERSION=${METASTORE_VERSION} \
				 -f ./Dockerfile \
				 -t ${REPO_NAME}:${METASTORE_VERSION}-hadoop-${BASE_TAG} \
				 .

push:
	docker push ${REPO_NAME}:${METASTORE_VERSION}-hadoop-${BASE_TAG}