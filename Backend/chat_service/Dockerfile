FROM maven:3.6.3-jdk-11-openj9

WORKDIR /chat_service
COPY . .
RUN mvn clean install
CMD mvn spring-boot:run