FROM gradle:6.3-jdk13

COPY . /tmp/elasticsearch-7.6.2
RUN groupadd elsearch && \
useradd -ms /bin/bash elsearch -g elsearch -p /tmp/elasticsearch-7.6.2 && \
chown -R elsearch:elsearch /tmp/elasticsearch-7.6.2
USER elsearch
RUN mkdir -p /home/elsearch/elasticsearch-7.6.2 && mv /tmp/elasticsearch-7.6.2 /home/elsearch && echo "vm.max_map_count=262144" > /etc/sysctl.conf && sysctl -p

WORKDIR /home/elsearch/elasticsearch-7.6.2/bin
EXPOSE 9200 9300

CMD [ "./elasticsearch" ]