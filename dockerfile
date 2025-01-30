FROM openjdk:8-jdk

# Install required packages
RUN apt-get update && apt-get install -y curl tar && rm -rf /var/lib/apt/lists/*

# Set Maven version
ENV MAVEN_VERSION 3.6.0
ENV MAVEN_HOME /opt/maven

# Download and install Maven
RUN curl -fsSL https://repo1.maven.org/maven2/org/apache/maven/apache-maven/3.6.0/apache-maven-3.6.0-bin.tar.gz \
    | tar -xz -C /opt && mv /opt/apache-maven-${MAVEN_VERSION} /opt/maven

# Set environment variables
ENV PATH="${MAVEN_HOME}/bin:${PATH}"

# Verify installation
RUN java -version && mvn -version

WORKDIR /app
CMD ["mvn", "--version"]
