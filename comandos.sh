#!/usr/bin/env bash
# Semana 3 - Red de contenedores MySQL + phpMyAdmin (comandos manuales)
set -e

# 1. Imágenes
docker pull mysql:8.0
docker pull phpmyadmin:latest

# 2. Red personalizada
docker network create red-pablo

# 3. Contenedor MySQL con credenciales
docker run -d \
  --name mysql-pablo \
  --network red-pablo \
  -e MYSQL_ROOT_PASSWORD=root1234 \
  -e MYSQL_USER=pablo \
  -e MYSQL_PASSWORD=pablo1234 \
  -e MYSQL_DATABASE=practica \
  -p 3306:3306 \
  mysql:8.0

# 4. Contenedor phpMyAdmin apuntando a MySQL por nombre
docker run -d \
  --name phpmyadmin-pablo \
  --network red-pablo \
  -e PMA_HOST=mysql-pablo \
  -e PMA_PORT=3306 \
  -p 8080:80 \
  phpmyadmin:latest

# 5. Comprobaciones
docker ps
docker network inspect red-pablo --format '{{range .Containers}}{{.Name}} -> {{.IPv4Address}}{{"\n"}}{{end}}'

echo "Abrir http://localhost:8080  (usuario: root / contraseña: root1234)"

# Limpieza (descomentar para borrar todo)
# docker rm -f phpmyadmin-pablo mysql-pablo
# docker network rm red-pablo
