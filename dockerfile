FROM openjdk:8-jdk

# Install required packages
RUN apt-get update && apt-get install -y curl tar && rm -rf /var/lib/apt/lists/*

# Set Maven version
ENV MAVEN_VERSION 3.6.0
ENV MAVEN_HOME /opt/maven

# Download and install Maven
RUN curl -fsSL https://downloads.apache.org/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
    | tar -xz -C /opt && mv /opt/apache-maven-${MAVEN_VERSION} /opt/maven

# Set environment variables
ENV PATH="${MAVEN_HOME}/bin:${PATH}"

# Verify installation
RUN java -version && mvn -version

WORKDIR /app
CMD ["mvn", "--version"]
