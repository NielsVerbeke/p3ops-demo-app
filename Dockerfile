# --- build stage (.NET 6) ---
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY . .
RUN dotnet restore src/Server/Server.csproj
RUN dotnet publish src/Server/Server.csproj -c Release -o /out

# --- runtime stage (.NET 6) ---
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY --from=build /out .
ENV ASPNETCORE_URLS=http://0.0.0.0:5000
EXPOSE 5000
ENTRYPOINT ["dotnet", "Server.dll"]
