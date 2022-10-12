FROM maven:3.8.2-jdk-11
WORKDIR /Backend/SEPT_Backend
COPY . .
RUN mvn install
CMD mvn spring-boot:run