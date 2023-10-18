FROM eclipse-temurin:21-jdk
USER root
WORKDIR /app

# Copy the JAR and application configuration files
COPY app.json /app/
COPY hello-java-1.0-SNAPSHOT-runner.jar /app/runner.jar

# Install NGINX and required packages
RUN apt-get update && apt-get install -y nginx

# Copy the NGINX configuration file
COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80 for NGINX
EXPOSE 80

# Start NGINX and your application
CMD service nginx start && java -jar -Dvertx.cacheDirBase=/tmp -Dquarkus.vertx.caching=false -Dquarkus.vertx.classpath-resolving=false -Dturbine.mode=deploy /app/runner.jar
