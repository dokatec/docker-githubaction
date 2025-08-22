# Dockerfile para aplicação .NET 7
# Imagem base do SDK para build
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build-env
WORKDIR /app

# Copia os arquivos do projeto
COPY . ./

# Restaura dependências
RUN dotnet restore

# Publica a aplicação
RUN dotnet publish -c Release -o out

# Imagem base para runtime
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS runtime
WORKDIR /app

# Copia arquivos publicados do build
COPY --from=build-env /app/out .

# Define porta padrão
EXPOSE 80

# Comando para iniciar a aplicação
ENTRYPOINT ["dotnet", "docker.dll"]
