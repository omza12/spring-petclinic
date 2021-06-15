# Step 1 - Run SonarQube
FROM sonarqube:latest as sonarqube
EXPOSE 9000
ENTRYPOINT ["./bin/run.sh"]

# Step 2 - Run MVNW
FROM maven:3.6.0-jdk-11-slim AS mvnw
WORKDIR /home/app/
COPY spring-petclinic/ ./spring-petclinic
RUN mvn -f /home/app/spring-petclinic/pom.xml clean package

# Step 3 - Package
FROM openjdk:11-jre-slim
COPY --from=mvnw /home/app/spring-petclinic/target/*.jar /usr/local/lib/*.jar
EXPOSE 8080
CMD ["java","-jar","/usr/local/lib/*.jar"] 