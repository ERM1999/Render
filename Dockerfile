# ETAPA 1: Compilar el proyecto con Maven
FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app
# Copiamos el pom.xml y el código fuente
COPY pom.xml .
COPY src ./src
# Compilamos y generamos el archivo .war (saltando los tests para ir más rápido)
RUN mvn clean package -DskipTests

# ETAPA 2: Configurar el servidor para ejecutar el .war
FROM payara/micro:6.2023.10-jdk17
# Copiamos el .war generado en la etapa anterior a la carpeta de despliegue de Payara
COPY --from=build /app/target/*.war $DEPLOY_DIR/app.war

# Exponemos el puerto 8080 que es el que usa Payara por defecto
EXPOSE 8080

# Comando para arrancar Payara Micro
ENTRYPOINT ["java", "-jar", "/opt/payara/payara-micro.jar", "--deploy", "/opt/payara/deployments/app.war", "--contextroot", "/penitenciaria-api"]