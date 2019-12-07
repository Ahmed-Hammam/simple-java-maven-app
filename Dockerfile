FROM maven:3-alpine
COPY src /home/app/src
COPY pom.xml /home/app
RUN curl -fsSLO https://get.docker.com/builds/Linux/x86_64/docker-17.04.0-ce.tgz \
  && tar xzvf docker-17.04.0-ce.tgz \
  && mv docker/docker /usr/local/bin \
  && rm -r docker docker-17.04.0-ce.tgz
RUN mvn -f /home/app/pom.xml clean install -U -DskipTests
