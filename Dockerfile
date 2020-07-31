FROM gradle:5.6.4-jdk12

COPY . /usr/elasticsearch
RUN chmod -R 777 /usr/elasticsearch && useradd -ms /bin/bash elasticsearch
USER elasticsearch

WORKDIR /usr/elasticsearch/bin
EXPOSE 9200 9300

CMD [ "./elasticsearch" ]