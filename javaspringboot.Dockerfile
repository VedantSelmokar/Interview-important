#Dockerfile for Java (Spring Boot Application)

FROM openjdk:17-jdk-slim

# Set working directory
WORKDIR /app

# Copy JAR file
COPY target/myapp.jar /app/myapp.jar

# Expose port
EXPOSE 8080

# Command to run the application
ENTRYPOINT ["java", "-jar", "myapp.jar"]
