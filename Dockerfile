FROM maven

COPY spring-petclinic-2.3.0.BUILD-SNAPSHOT.jar /main.jar

ENTRYPOINT ["java",  "-jar", "/main.jar"]
