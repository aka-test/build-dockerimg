FROM ubuntu:20.04

# Set environment variables
ENV JAVA_VERSION=1.8.0_202
ENV JAVA_HOME=/usr/lib/jvm/jdk1.8.0_202
ENV MAVEN_VERSION=3.6.0
ENV MAVEN_HOME=/usr/share/maven
ENV PATH="$JAVA_HOME/bin:$MAVEN_HOME/bin:$PATH"

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    curl \
    tar \
    unzip \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install JDK 1.8.0_202 (Manually Download & Extract)
RUN wget -q --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" \
    https://download.oracle.com/otn-pub/java/jdk/8u202-b08/jdk-8u202-linux-x64.tar.gz -O /tmp/jdk.tar.gz && \
    mkdir -p /usr/lib/jvm && \
    tar -xzf /tmp/jdk.tar.gz -C /usr/lib/jvm && \
    rm -f /tmp/jdk.tar.gz

# Install Maven 3.6.0
RUN wget -q "https://repo1.maven.org/maven2/org/apache/maven/apache-maven/3.6.0/apache-maven-3.6.0-bin.tar.gz" -O /tmp/maven.tar.gz && \
    mkdir -p "$MAVEN_HOME" && \
    tar -xvzf /tmp/maven.tar.gz --strip-components=1 -C "$MAVEN_HOME" && \
    rm -f /tmp/maven.tar.gz

# Verify installation
RUN java -version && mvn -version

# Set working directory
WORKDIR /app

CMD ["mvn", "-version"]
