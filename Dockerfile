ARG BASEIMAGE=debian:bullseye-slim
FROM ${BASEIMAGE}

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION

LABEL mantainer="Eloy Lopez <elswork@gmail.com>" \
    org.opencontainers.image.title=MailUtils \
    org.opencontainers.image.description="A Docker image with mailutils and ssmtp to send emails." \
    org.opencontainers.image.vendor=Deft.Work \
    org.opencontainers.image.url=https://deft.work/mailutils \
    org.opencontainers.image.source=https://github.com/elswork/MailUtils \
    org.opencontainers.image.version=$VERSION \ 
    org.opencontainers.image.created=$BUILD_DATE \
    org.opencontainers.image.revision=$VCS_REF \
    org.opencontainers.image.licenses=MIT

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
