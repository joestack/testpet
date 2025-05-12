FROM eclipse-temurin:17-jdk-jammy as builder
WORKDIR /app
COPY .mvn/ .mvn
COPY mvnw pom.xml ./
RUN chmod +x mvnw
RUN ./mvnw dependency:go-offline
COPY src ./src
RUN ./mvnw package -DskipTests --debug

FROM eclipse-temurin:17-jre-jammy
COPY --from=builder /app/target/*.jar /app/spring-petclinic.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/spring-petclinic.jar"]
