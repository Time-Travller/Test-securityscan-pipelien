FROM maven:3.9.9-eclipse-temurin-21 AS build
WORKDIR /src
COPY pom.xml .
COPY src ./src
RUN mvn -B -DskipTests package dependency:copy-dependencies -DincludeScope=compile

FROM eclipse-temurin:21-jre
WORKDIR /app
COPY --from=build /src/target/java21-ci-1.0.0.jar app.jar
COPY --from=build /src/target/dependency/ /app/lib/
ENTRYPOINT ["java", "-jar", "app.jar"]
