FROM gradle:5.6.2-jdk12

COPY . /tmp/elasticsearch-7.5.1

RUN groupadd elsearch && \
    useradd -ms /bin/bash elsearch -g elsearch -p /tmp/elasticsearch-7.5.1 && \
    chown -R elsearch:elsearch /tmp/elasticsearch-7.5.1 && \
    mkdir -p /home/elsearch/elasticsearch-7.5.1 && \
    mv /tmp/elasticsearch-7.5.1 /home/elsearch && \
    chmod 777 /etc/sysctl.conf && \
    echo "vm.max_map_count=262144" > /etc/sysctl.conf && sysctl -p
USER elsearch

WORKDIR /home/elsearch/elasticsearch-7.5.1/bin
EXPOSE 9200 9300

CMD [ "./elasticsearch" ]