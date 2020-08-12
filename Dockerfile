FROM gradle:5.6.2-jdk12

COPY . /tmp/elasticsearch

RUN build_deps="curl" && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends ${build_deps} ca-certificates && \
    curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends apt-utils git-lfs && \
    DEBIAN_FRONTEND=noninteractive apt-get purge -y --auto-remove ${build_deps} && \
    rm -r /var/lib/apt/lists/*
RUN groupadd elsearch && \
    useradd -ms /bin/bash elsearch -g elsearch -p /tmp/elasticsearch && \
    chown -R elsearch:elsearch /tmp/elasticsearch && \
    mv /tmp/elasticsearch /home/elsearch && \
    cd /home/elsearch/elasticsearch && \
    git remote set-url origin https://github.com/huangxinping/elasticsearch.git && \ 
    git lfs install && \
    git lfs pull
USER elsearch

WORKDIR /home/elsearch/elasticsearch/bin
EXPOSE 9200 9300

CMD [ "./elasticsearch" ]