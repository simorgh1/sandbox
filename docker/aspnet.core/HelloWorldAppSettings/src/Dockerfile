FROM mcr.microsoft.com/dotnet/core/aspnet:3.1-buster-slim AS base
WORKDIR /app

LABEL author="Bahram Maravandi"
ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080

FROM mcr.microsoft.com/dotnet/core/sdk:3.1-buster AS build
WORKDIR /src
COPY ["helloWorld.csproj", "/src"]
RUN dotnet restore "helloWorld.csproj"

COPY . .

RUN dotnet build "helloWorld.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "helloWorld.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "helloWorld.dll"]
