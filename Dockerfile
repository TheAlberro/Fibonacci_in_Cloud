
FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build-env
WORKDIR /app


COPY ./Fibonacci_in_Cloud/*.csproj ./
RUN dotnet restore 

COPY . ./
RUN dotnet publish -c Release -o out


FROM mcr.microsoft.com/dotnet/core/aspnet:3.1-alpine
WORKDIR /app
EXPOSE 80
COPY --from=build-env /app/out .


ENTRYPOINT ["dotnet","Fibonacci_in_Cloud.dll"]
