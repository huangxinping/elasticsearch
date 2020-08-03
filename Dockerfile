FROM gradle:5.6.4-jdk12

COPY . /home/elasticsearch
RUN useradd -ms /bin/bash elasticsearch && chown -R elasticsearch:elasticsearch /home/elasticsearch && chmod -R 777 /home/elasticsearch
USER elasticsearch

WORKDIR /home/elasticsearch/bin
EXPOSE 9200 9300

CMD [ "./elasticsearch" ]