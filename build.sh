docker rm -f $(docker ps -aq)
docker rmi -f $(docker images -aq)
docker volume prune -f

docker build --no-cache -t huangxinping/es .