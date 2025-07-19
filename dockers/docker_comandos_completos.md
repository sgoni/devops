[//]: # (¶ç)

# 🐳 Guía Completa de Comandos Docker con Ejemplos

---

## ✅ 1. Introducción & Comprobación

```bash
docker --version
docker info
docker system info
```

## 📦 2. Imágenes (Images)

### 📥 Descargar imágenes

```bash
docker pull nginx
docker pull ubuntu:22.04
```

### 🔍 Buscar imágenes

```bash
docker search postgres
```

### 📄 Listar imágenes

```bash
docker images
```

### ❌ Eliminar imágenes

```bash
docker rmi nginx
docker rmi -f imagen_id
```

## 🧱 3. Contenedores (Containers)

### 🚀 Crear y correr contenedores

```bash
docker run hello-world
docker run -it ubuntu bash
docker run -d nginx
docker run -p 8080:80 nginx
docker run -v $(pwd):/app ubuntu
docker run --name miweb nginx
```

### 🧾 Listar contenedores

```bash
docker ps
docker ps -a
```

### 🔄 Control de ejecución

```bash
docker stop contenedor_id
docker start contenedor_id
docker restart contenedor_id
docker pause contenedor_id
docker unpause contenedor_id
```

### ❌ Eliminar contenedores

```bash
docker rm contenedor_id
docker rm -f contenedor_id
```

## 🛠️ 4. Docker Exec & Attach

### 🧑‍💻 Ejecutar comandos dentro del contenedor

```bash
docker exec -it contenedor_id bash
docker exec -it contenedor_id ls /var/www
```

### 📎 Adjuntar a un contenedor

```bash
docker attach contenedor_id
```

## 🏗️ 5. Dockerfile (Crear imágenes personalizadas)

### 📄 Ejemplo básico de Dockerfile

```Dockerfile
FROM node:18
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 3000
CMD ["node", "index.js"]
```

### 🔧 Build y uso

```bash
docker build -t mi-app .
docker run -p 3000:3000 mi-app
```

## 🧃 6. Docker Volúmenes (Persistencia de datos)

### 📦 Crear y montar volumen

```bash
docker volume create mi_volumen
docker run -v mi_volumen:/data ubuntu
```

### 📄 Ver volúmenes

```bash
docker volume ls
docker volume inspect mi_volumen
```

### ❌ Eliminar volumen

```bash
docker volume rm mi_volumen
```

## 🌐 7. Redes (Networking)

### 📡 Ver redes existentes

```bash
docker network ls
```

### 🌐 Crear red

```bash
docker network create mi_red
```

### 📦 Asignar contenedor a red

```bash
docker run -d --network=mi_red --name=web nginx
docker run -d --network=mi_red --name=app mi-app
```

## 🧩 8. Docker Compose

### 📄 Ejemplo `docker-compose.yml`

```yaml
version: '3.8'
services:
  web:
    image: nginx
    ports:
      - "8080:80"

  app:
    build: .
    ports:
      - "3000:3000"
    volumes:
      - .:/app
    depends_on:
      - db

  db:
    image: postgres
    environment:
      POSTGRES_PASSWORD: ejemplo123
```

### ⚙️ Comandos

```bash
docker-compose up
docker-compose up -d
docker-compose down
docker-compose ps
docker-compose logs -f
```

## 🧹 9. Limpieza de recursos

```bash
docker system prune
docker container prune
docker image prune
docker volume prune
```

## 📋 10. Tips útiles

- Inspeccionar contenedor o imagen:

```bash
docker inspect nombre_o_id
```

- Copiar archivos dentro/fuera de contenedor:

```bash
docker cp archivo.txt contenedor:/destino/
docker cp contenedor:/archivo.txt ./
```

- Logs de un contenedor:

```bash
docker logs contenedor
docker logs -f contenedor
```
