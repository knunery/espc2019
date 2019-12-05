docker kill $(docker ps -q)
docker rm $(docker ps -a -q)
docker rmi $(docker images -q)
docker rmi romeimages.azurecr.io/expertslive-ui:1cd
docker images