FROM alpine/git AS builder
COPY . /tmp/elasticsearch
WORKDIR /tmp/elasticsearch   
RUN rm /etc/apk/repositories && echo http://mirrors.aliyun.com/alpine/v3.9/main > /etc/apk/repositories && \
    echo http://mirrors.aliyun.com/alpine/v3.9/community >> /etc/apk/repositories && \
    apk --no-cache add git-lfs && \
    git remote set-url origin https://github.com/huangxinping/elasticsearch.git && \
    git remote get-url --all origin && \
    git lfs install && \
    git lfs pull && \
    find . -name ".DS_Store" -print -delete && \
    rm -rf .git/ .gitattributes .gitignore Dockerfile LICENSE.txt NOTICE.txt README.textile
    
FROM gradle:5.6.2-jdk12
COPY --from=builder /tmp/elasticsearch /tmp/elasticsearch
RUN groupadd elsearch && \
    useradd -ms /bin/bash elsearch -g elsearch -p /tmp/elasticsearch && \
    chown -R elsearch:elsearch /tmp/elasticsearch && \
    mv /tmp/elasticsearch /home/elsearch
USER elsearch
WORKDIR /home/elsearch/elasticsearch/bin
EXPOSE 9200 9300

CMD [ "./elasticsearch" ]