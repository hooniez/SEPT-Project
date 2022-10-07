FROM openjdk:11
ADD SEPT-Project.jar SEPT-Project.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "SEPT-Project.jar"]
