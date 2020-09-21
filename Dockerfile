FROM openjdk:14-jdk

EXPOSE 8080
COPY target/spring-petclinic-2.3.0.BUILD-SNAPSHOT.jar /main.jar

ENTRYPOINT ["java",  "-jar", "/main.jar"]
