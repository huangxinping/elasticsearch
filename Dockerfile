FROM gradle:5.6.2-jdk12

COPY . /tmp/elasticsearch-7.5.1

RUN build_deps="curl" && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends ${build_deps} ca-certificates && \
    curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends apt-utils git-lfs && \
    git lfs install && \
    DEBIAN_FRONTEND=noninteractive apt-get purge -y --auto-remove ${build_deps} && \
    rm -r /var/lib/apt/lists/*
RUN groupadd elsearch && \
    useradd -ms /bin/bash elsearch -g elsearch -p /tmp/elasticsearch-7.5.1 && \
    chown -R elsearch:elsearch /tmp/elasticsearch-7.5.1 && \
    mkdir -p /home/elsearch/elasticsearch-7.5.1 && \
    mv /tmp/elasticsearch-7.5.1 /home/elsearch && \
    cd /home/elsearch/elasticsearch-7.5.1 && git lfs pull && \
    chmod 777 /etc/sysctl.conf && \
    echo "vm.max_map_count=262144" > /etc/sysctl.conf && sysctl -p
USER elsearch

WORKDIR /home/elsearch/elasticsearch-7.5.1/bin
EXPOSE 9200 9300

CMD [ "./elasticsearch" ]