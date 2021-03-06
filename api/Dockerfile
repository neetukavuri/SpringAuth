FROM maven:3.5.3-jdk-8-alpine
WORKDIR "/app"
COPY . .
RUN mvn install
RUN cp target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]
