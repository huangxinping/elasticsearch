FROM ubuntu:18.04

COPY elasticsearch-7.7.0 /home/elasticsearch
COPY jdk-14 /usr/java/jdk-14

RUN echo '\n\
JAVA_HOME=/usr/java/jdk-14\n\
PATH=$PATH:$HOME/bin:$JAVA_HOME/bin\n\
export JAVA_HOME\n\
export JRE_HOME\n\
export PATH' >> /etc/profile && \
update-alternatives --install "/usr/bin/java" "java" "/usr/java/jdk-14/bin/java" 1 && \
update-alternatives --install "/usr/bin/javac" "javac" "/usr/java/jdk-14/bin/javac" 1 && \
cd /home/elasticsearch && chmod +x ./gradlew && ./gradlew assemble && \
useradd -ms /bin/bash elasticsearch

USER elasticsearch

WORKDIR /home/elasticsearch/bin

# CMD [ "./elasticsearch" ]