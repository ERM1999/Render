# ETAPA 1: Compilar
FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# ETAPA 2: Ejecutar
FROM payara/micro:6.2023.10-jdk17

# Copiamos el archivo forzando el nombre a 'app.war'
COPY --from=build /app/target/*.war /opt/payara/deployments/app.war

# EXPOSE el puerto
EXPOSE 8080

# ENTRYPOINT mejorado:
# 1. Silenciamos el error de Hazelcast
# 2. Forzamos la ruta raíz "/"
ENTRYPOINT ["java", "-Dhz.network.rest-api.enabled=false", "-jar", "/opt/payara/payara-micro.jar", "--deploy", "/opt/payara/deployments/app.war", "--contextroot", "/"]