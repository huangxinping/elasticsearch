FROM gradle:6.4.1-jdk14

COPY elasticsearch-7.7.0 /usr/elasticsearch

RUN cd /usr/elasticsearch && chmod +x ./gradlew && ./gradlew assemble && \
useradd -ms /bin/bash elasticsearch

USER elasticsearch

WORKDIR /usr/elasticsearch/bin

# CMD [ "./elasticsearch" ]