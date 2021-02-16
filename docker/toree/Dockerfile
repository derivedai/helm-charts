ARG BASE_IMAGE
FROM ${BASE_IMAGE}

COPY dist/ /tmp 

RUN mkdir /opt/toree && \
    tar -zxvf /tmp/toree-0.6.0.dev1-incubating-bin.tar.gz -C /opt/toree --strip-components=1 && \
    rm -rf /tmp/toree-0.6.0.dev1-incubating-bin.tar.gz


ENV DECL_WIDGETS_VERSION 0.4.3

# install incubator extensions
RUN conda install jupyter -y

RUN pip install /tmp/toree-pip-0.6.0.dev1.tar.gz

ENV TOREE_HOME  /opt/toree
ENV PATH    ${TOREE_HOME}/bin:$PATH
