# Usar una imagen base de Debian ligera
FROM debian:bullseye-slim

# Instalar mailutils y ssmtp
# -y para aceptar automáticamente
# --no-install-recommends para minimizar el tamaño
# Al final, limpiar la caché de apt para mantener la imagen pequeña
RUN apt-get update && \
    apt-get install -y --no-install-recommends mailutils ssmtp && \
    rm -rf /var/lib/apt/lists/*

# Establecer un directorio de trabajo
WORKDIR /root

# Comando por defecto para mantener el contenedor en ejecución
# Esto nos permite usar `docker exec` para enviar correos.
CMD ["tail", "-f", "/dev/null"]
