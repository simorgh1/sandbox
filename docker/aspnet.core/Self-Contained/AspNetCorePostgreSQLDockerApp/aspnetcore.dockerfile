FROM mcr.microsoft.com/dotnet/core/runtime-deps:3.1-alpine3.10 AS base

WORKDIR /app

LABEL author="Bahram Maravandi"
ENV ASPNETCORE_URLS=http://+:5000 \
    ASPNETCORE_ENVIRONMENT=Development

EXPOSE 5000

FROM mcr.microsoft.com/dotnet/core/sdk:3.1-buster AS build
WORKDIR /src
COPY ["AspNetCorePostgreSQLDockerApp.csproj", "/src"]
RUN dotnet restore "AspNetCorePostgreSQLDockerApp.csproj"

COPY . .

RUN dotnet build "AspNetCorePostgreSQLDockerApp.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "AspNetCorePostgreSQLDockerApp.csproj" -c Release -r linux-musl-x64 --self-contained -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["sh", "-c", "./AspNetCorePostgreSQLDockerApp"]