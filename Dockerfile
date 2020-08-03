FROM gradle:5.6.4-jdk12

COPY . /usr/elasticsearch
RUN useradd -ms /bin/bash elasticsearch && chown -R elasticsearch:elasticsearch /usr/elasticsearch && chmod -R 777 /usr/elasticsearch
USER elasticsearch

WORKDIR /usr/elasticsearch/bin
EXPOSE 9200 9300

CMD [ "./elasticsearch" ]