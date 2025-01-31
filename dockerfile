FROM openjdk:8u202-jdk

# Install Maven 3.6.0
RUN apt-get update && apt-get install -y wget && \
    wget -q "https://repo1.maven.org/maven2/org/apache/maven/apache-maven/3.6.0/apache-maven-3.6.0-bin.tar.gz" -O /tmp/maven.tar.gz && \
    mkdir -p /usr/share/maven && \
    tar -xvzf /tmp/maven.tar.gz --strip-components=1 -C /usr/share/maven && \
    rm -f /tmp/maven.tar.gz

ENV MAVEN_HOME=/usr/share/maven
ENV PATH="$MAVEN_HOME/bin:$PATH"

WORKDIR /app
CMD ["mvn", "-version"]
