FROM mcr.microsoft.com/dotnet/core/aspnet:latest AS base
WORKDIR /app

LABEL author="Bahram Maravandi"
ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080

FROM mcr.microsoft.com/dotnet/core/sdk:latest AS build
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
