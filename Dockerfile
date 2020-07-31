FROM ubuntu:18.04

SHELL ["/bin/bash", "-c"] 

COPY elasticsearch-7.7.0 /usr/elasticsearch
COPY jdk-14 /usr/java/jdk-14
COPY gradle-6.4 /usr/gradle/gradle-6.4

RUN echo '\n\
JAVA_HOME=/usr/java/jdk-14 \n\
GRADLE_HOME=/usr/gradle/gradle-6.4 \n\
PATH=$PATH:$HOME/bin:$JAVA_HOME/bin:$GRADLE_HOME/bin \n\
export JAVA_HOME \n\
export JRE_HOME \n\
export GRADLE_HOME \n\
export PATH' >> /etc/profile && \
update-alternatives --install "/usr/bin/java" "java" "/usr/java/jdk-14/bin/java" 1 && \
update-alternatives --install "/usr/bin/javac" "javac" "/usr/java/jdk-14/bin/javac" 1 && \
update-alternatives --install "/usr/bin/gradle" "gradle" "/usr/gradle/gradle-6.4/bin/gradle" 1 && \
cd /usr/elasticsearch && chmod +x ./gradlew && ./gradlew assemble && \
useradd -ms /bin/bash elasticsearch

USER elasticsearch

WORKDIR /usr/elasticsearch/bin

# CMD [ "./elasticsearch" ]