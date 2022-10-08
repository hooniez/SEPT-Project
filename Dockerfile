FROM openjdk:11
ADD SEPT_Backend-0.0.1-SNAPSHOT.jar SEPT_Backend-0.0.1-SNAPSHOT.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "SEPT_Backend-0.0.1-SNAPSHOT.jar"]
