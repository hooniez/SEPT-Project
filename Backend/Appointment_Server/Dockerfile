FROM maven:3.8.2-jdk-11
WORKDIR /Backend/Appointment_Server
COPY . .
RUN mvn install
CMD mvn spring-boot:run