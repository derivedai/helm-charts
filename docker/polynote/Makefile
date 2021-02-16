BASE_IMAGE ?= derivedai/spark
BASE_TAG ?= 3.0.1-hadoop-3.3.0
SPARK_VERSION ?= 3.0.1
REPO_NAME ?= derivedai/polynote

build:
	docker build --build-arg BASE_IMAGE=${BASE_IMAGE}:${BASE_TAG} \
				 -f ./Dockerfile \
				 -t ${REPO_NAME}:latest \
				 .