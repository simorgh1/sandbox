FROM mcr.microsoft.com/dotnet/core/aspnet:latest AS base
WORKDIR /app

LABEL author="Bahram Maravandi"

FROM mcr.microsoft.com/dotnet/core/sdk:latest AS build
WORKDIR /src
COPY ["helloworld.csproj", "/src"]
RUN dotnet restore "helloworld.csproj"

COPY . .

RUN dotnet build "helloworld.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "helloworld.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "helloworld.dll"]
