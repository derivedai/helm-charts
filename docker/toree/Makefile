BASE_IMAGE ?= derivedai/spark
BASE_TAG ?= 3.0.1-hadoop-3.3.0
SPARK_VERSION ?= 3.0.1
REPO_NAME ?= derivedai/toree
TOREE_VERSION ?= 0.6.0.dev1
build:
	docker build --build-arg BASE_IMAGE=${BASE_IMAGE}:${BASE_TAG} \
				 -f ./Dockerfile \
				 -t ${REPO_NAME}:latest \
				 .

/tmp/incubator-toree:
	git -C /tmp clone https://github.com/apache/incubator-toree

/tmp/incubator-toree/dist/toree-bin/toree-${TOREE_VERSION}-incubating-bin.tar.gz: /tmp/incubator-toree
	cd /tmp/incubator-toree && \
	make APACHE_SPARK_VERSION=${SPARK_VERSION} pip-release bin-release

/tmp/incubator-toree/dist/toree-pip/toree-${TOREE_VERSION}.tar.gz: /tmp/incubator-toree/dist/toree-bin/toree-${TOREE_VERSION}-incubating-bin.tar.gz
toree: /tmp/incubator-toree/dist/toree-bin/toree-${TOREE_VERSION}-incubating-bin.tar.gz /tmp/incubator-toree/dist/toree-pip/toree-${TOREE_VERSION}.tar.gz

dist: toree
	cp /tmp/incubator-toree/dist/toree-pip/toree-${TOREE_VERSION}.tar.gz dist/toree-pip-${TOREE_VERSION}.tar.gz
	cp /tmp/incubator-toree/dist/toree-bin/toree-${TOREE_VERSION}-incubating-bin.tar.gz dist/toree-${TOREE_VERSION}-incubating-bin.tar.gz
push:
	docker push ${REPO_NAME}:latest