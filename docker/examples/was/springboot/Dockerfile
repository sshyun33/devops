FROM frolvlad/alpine-oraclejdk8:slim

MAINTAINER sshyun33@gmail.com

ADD build/libs/*.jar app.jar

ENV JAVA_OPTS=""

ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar /app.jar" ]

EXPOSE 8080
