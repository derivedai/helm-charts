ARG BASE_IMAGE
FROM ${BASE_IMAGE}

RUN wget https://github.com/polynote/polynote/releases/download/0.3.12/polynote-dist-2.12.tar.gz \
        -O /tmp/polynote.tar.gz && \
    mkdir -p /opt/polynote && \
    tar -zxvf /tmp/polynote.tar.gz -C /opt/polynote --strip-components=1 && \
    rm -rf /tmp/polynote.tar.gz 

ENV POLYNOTE_HOME   /opt/polynote
ENV PATH            ${POLYNOTE_HOME}:${PATH}

RUN apt install build-essential -y
RUN pip install -r /opt/polynote/requirements.txt