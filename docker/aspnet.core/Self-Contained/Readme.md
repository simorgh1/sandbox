#### Self-contained aspnet.core mvc for Linux runtime

A Self-contained publish, targets a certain .NET Core runtime identifier [RID Catalog](https://docs.microsoft.com/en-us/dotnet/core/rid-catalog) and could be usefull to reduce the size of the docker image.

In this sample, we target Linux alpine, which is one of the smallest Linux distributions, but we have to keep in mind that dotnet needs some system dependencies which must be available on the system, even though the dotnet publish builds all dotnet related libraries into the application's built package. 

Therefore it is essentional to choose the right base docker image, which is in this case [mcr.microsoft.com/dotnet/core/runtime-deps:3.1-alpine3.10](https://hub.docker.com/_/microsoft-dotnet-core-runtime-deps/).

For windows, we mostly could use windows nano server, but it must be checked.

This sample is using docker compose for orchesrtration and is a simple ASP.NET Core mvc app, which hosts an angular part as a spa, and it communicates with the .net core rest api, which is using PostgreSQL server.

In addition, I've added postgres admin for the case the database needs to be checked or any other query or database management should be necessary.

#### How to run?

First build the image using docker-compose build, after that run the application using docker-comoose up

The application should be available in http://localhost:5000 or http://192.168.99.100:5000 for docker toolbox setup.

The PostgresAdmin web interface is listening to 5050, use the configured email address and admin as the username/password.