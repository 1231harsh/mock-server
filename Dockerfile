# Stage 1: Build the Spring Boot app (Java 21)
FROM maven:3.9.9-eclipse-temurin-21 AS build

WORKDIR /app

# Copy backend source
COPY proj-chat-website-Backend /app

# Build the application
RUN mvn clean package -DskipTests

# Stage 2: Run with lightweight JDK 21
FROM eclipse-temurin:21-jdk-jammy

WORKDIR /app

# Copy jar from build stage
COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080

CMD ["java", "-jar", "app.jar"]