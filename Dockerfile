ARG APP_NAME=hello-1.0.jar
# Use a base image with Java pre-installed
FROM openjdk:11-jre-slim

# Set the working directory in the container
WORKDIR /app

# Copy the .jar file into the container at /app directory
COPY ./build/libs/$APP_NAME /app/$APP_NAME/hello-world-1.0.jar

# Expose the port that the application will run on (adjust if needed)
EXPOSE 8080

# Run the jar file
ENTRYPOINT ["java", "-jar", "/app/hello-world-1.0.jar"]
