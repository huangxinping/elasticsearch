FROM gradle:6.4-jdk14

COPY . /tmp/elasticsearch-7.7.0
RUN groupadd elsearch && \
useradd -ms /bin/bash elsearch -g elsearch -p /tmp/elasticsearch-7.7.0 && \
chown -R elsearch:elsearch /tmp/elasticsearch-7.7.0
USER elsearch
RUN mkdir -p /home/elsearch/elasticsearch-7.7.0 && mv /tmp/elasticsearch-7.7.0 /home/elsearch && echo "vm.max_map_count=262144" > /etc/sysctl.conf && sysctl -p

WORKDIR /home/elsearch/elasticsearch-7.7.0/bin
EXPOSE 9200 9300

CMD [ "./elasticsearch" ]