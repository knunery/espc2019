docker build -f ./src/DutchAzureMeetup.WebApp/Dockerfile . -t romeimages.azurecr.io/expertslive-ui:1

docker build -f src/DutchAzureMeetup.WebApi/Dockerfile . -t romeimages.azurecr.io/expertslive-api:1


docker run -it -p 8585:80 -e ConnectionStrings__DutchAzureMeetupContext="Server=tcp:dutchazuremeetup.database.windows.net,1433;Initial Catalog=dutchazuremeetup;Persist Security Info=False;User ID=dutchazuremeetup;Password=We<3@zure;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;" romeimages.azurecr.io/expertslive-api:1
docker run -it -p 8585:80 romeimages.azurecr.io/expertslive-api:1

docker login romeimages.azurecr.io -u romeimages -p p/FMWvVuOIOlm9N1dt9ZfSQoglqbUprw

docker push romeimages.azurecr.io/expertslive-api:1