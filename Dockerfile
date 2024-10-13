FROM maven:3.9-eclipse-temurin-22-alpine AS build

WORKDIR /app

COPY pom.xml ./

# Descargar dependencias para acelerar futuras construcciones
RUN mvn dependency:go-offline

COPY src ./src

RUN mvn clean package -DskipTests


FROM openjdk:22-jdk-slim

WORKDIR /app

COPY --from=build /app/target/eureka-ms-0.0.1.jar /app/eureka-ms-0.0.1.jar

EXPOSE 8761

ENTRYPOINT ["java", "-jar", "/app/eureka-ms-0.0.1.jar"]