# Build Stage
FROM maven:3.8.4-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Runtime Stage
FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar

# Use container network host for Postgres
ENV DATABASE_URL=jdbc:postgresql://postgres:80/postgres
ENV DATABASE_USER=admin
ENV DATABASE_PASSWORD=1234

EXPOSE 8081
ENTRYPOINT ["java", "-jar", "app.jar"]