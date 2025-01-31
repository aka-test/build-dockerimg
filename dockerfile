FROM openjdk:8-jdk

# Set environment variables
ENV MAVEN_VERSION=3.6.0
ENV MAVEN_HOME=/usr/share/maven
ENV PATH="$MAVEN_HOME/bin:$PATH"

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    bzip2 \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Download and install Maven 3.6.0
RUN wget -q "https://repo1.maven.org/maven2/org/apache/maven/apache-maven/3.6.0/apache-maven-3.6.0-bin.tar.gz" -O /tmp/maven.tar.gz && \
    mkdir -p "$MAVEN_HOME" && \
    tar -xvzf /tmp/maven.tar.gz --strip-components=1 -C "$MAVEN_HOME" && \
    rm -f /tmp/maven.tar.gz

# Verify installation
RUN java -version && mvn -version

# Set working directory
WORKDIR /app

CMD ["mvn", "-version"]
