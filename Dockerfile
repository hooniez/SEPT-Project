FROM openjdk:11
ADD Appointment_Server-0.0.1-SNAPSHOT.jar Appointment_Server-0.0.1-SNAPSHOT.jar
EXPOSE 8081
ENTRYPOINT ["java", "-jar", "Appointment_Server-0.0.1-SNAPSHOT.jar"]
