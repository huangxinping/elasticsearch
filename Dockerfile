FROM alpine/git AS builder
COPY . /tmp/elasticsearch
WORKDIR /tmp/elasticsearch   
RUN apk --no-cache add git-lfs && \
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