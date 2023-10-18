FROM eclipse-temurin:21-jdk
USER root
WORKDIR /app

COPY app.json /app/
COPY hello-java-1.0-SNAPSHOT-runner.jar /app/runner.jar

ENTRYPOINT ["java", "-jar", "-Dvertx.cacheDirBase=/tmp", "-Dquarkus.vertx.caching=false", "-Dquarkus.vertx.classpath-resolving=false", "-Dturbine.mode=deploy", "/app/runner.jar"]
