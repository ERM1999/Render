# 1. Usamos una imagen de Maven para compilar (opcional si ya subes el war, pero recomendado)
FROM maven:3.8.4-openjdk-17 AS build
COPY . /app
WORKDIR /app
RUN mvn clean package

# 2. Usamos la imagen de Payara Micro
FROM payara/micro:6.2023.10

# COPIA el archivo generado a la carpeta de despliegue de Payara
# El nombre debe coincidir con el <finalName> de tu pom.xml
COPY --from=build /app/target/ROOT.war ${DEPLOY_DIR}

# Comando de ejecución

ENTRYPOINT ["java", "-jar", "/opt/payara/payara-micro.jar", "--port", "10000", "--deploy", "/opt/payara/deployments/ROOT.war", "--contextroot", "/"]