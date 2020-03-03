FROM gradle:4.6-jdk8-alpine as compile
COPY . /home/source/java
WORKDIR /home/source/java
# Default gradle user is `gradle`. We need to add permission on working directory for gradle to build.
USER root
RUN chown -R gradle /home/source/java
USER gradle
RUN gradle clean build

FROM openjdk:8-jre-alpine
WORKDIR /home/application/java
COPY --from=compile "/home/source/java/build/libs/gs-spring-boot-0.1.0.jar" .
EXPOSE 8080
ENTRYPOINT [ "java", "-jar", "/home/application/java/gs-spring-boot-0.1.0.jar"]