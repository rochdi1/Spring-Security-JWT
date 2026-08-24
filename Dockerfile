# Stage 1: Build der Anwendung mit Maven (nutzt Temurin JDK 17)
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
# Abhängigkeiten vorab herunterladen für besseres Caching
RUN mvn dependency:go-offline -B
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Sicheres und schlankes Laufzeit-Image mit Eclipse Temurin 17
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]

