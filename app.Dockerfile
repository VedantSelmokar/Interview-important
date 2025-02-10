FROM openjdk:17-jdk-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the application JAR file into the container
COPY target/myapp.jar /app/myapp.jar

# Expose the application's port (modify as per your app's requirements)
EXPOSE 8080

# Run the application
CMD ["java", "-jar", "myapp.jar"]
