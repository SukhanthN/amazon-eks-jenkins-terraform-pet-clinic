FROM openjdk:8
# VOLUME /tmp
EXPOSE 8080
ADD target/spring-petclinic-2.1.0.jar app.jar
ENTRYPOINT ["java","-jar","app.jar"]
# ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]
