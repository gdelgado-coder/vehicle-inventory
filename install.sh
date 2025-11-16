#!/usr/bin/env bash

echo "======================================="
echo " 🔧 Inicializando ambiente..."
echo "======================================="

# 1. Verificar Docker
if ! command -v docker &> /dev/null
then
    echo "❌ Docker não está instalado! Instale antes de continuar."
    exit 1
fi

if ! command -v docker compose &> /dev/null
then
    echo "❌ Docker Compose V2 não encontrado! Atualize o Docker."
    exit 1
fi

echo "✔ Docker OK"


# 2. Subir containers
echo "======================================="
echo " 🐳 Subindo containers com Docker Compose..."
echo "======================================="
if ! docker compose up -d --build; then
    echo "❌ Falha ao subir containers!"
    exit 1
fi

echo "✔ Containers iniciados"


# 3. Aguardar MySQL ficar pronto
echo "======================================="
echo " ⏳ Aguardando MySQL ficar disponível..."
echo "======================================="

MYSQL_CONTAINER=$(docker ps --format "{{.Names}}" | grep vehicle-inventory-full-mysql | head -n 1)

if [ -z "$MYSQL_CONTAINER" ]; then
    echo "❌ Container MySQL não encontrado!"
    exit 1
fi

until docker exec "$MYSQL_CONTAINER" mysqladmin ping -h "localhost" --silent; do
    printf "."
    sleep 2
done

echo "✔ MySQL disponível"


# 4. Importar schema (se existir)
if [ -f "./database/init.sql" ]; then
    echo "======================================="
    echo " 📦 Importando schema inicial..."
    echo "======================================="

    docker exec -i "$MYSQL_CONTAINER" \
        mysql -uroot -proot < ./database/init.sql

    echo "✔ Schema importado"
else
    echo "⚠ Nenhum arquivo database/init.sql encontrado. Pulando importação."
fi


# 5. Instalar dependências Python (se existir o serviço)
SEARCH_CONTAINER=$(docker ps --format "{{.Names}}" | grep megastore | head -n 1)

if [ -n "$SEARCH_CONTAINER" ]; then
    echo "======================================="
    echo " 🐍 Instalando dependências do serviço megastore_search..."
    echo "======================================="
    docker exec "$SEARCH_CONTAINER" pip install -r requirements.txt || echo "⚠ Falha ao instalar dependências Python"
    echo "✔ Dependências Python instaladas"
else
    echo "⚠ Container do serviço Python não encontrado. Pulando."
fi


echo "======================================="
echo " 🚀 Ambiente pronto para testes!"
echo "======================================="
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
