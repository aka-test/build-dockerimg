FROM maven:3.6.0-jdk-8

# Ensure package lists are updated and install dependencies
RUN echo "deb http://deb.debian.org/debian stretch main" > /etc/apt/sources.list && \
    echo "deb http://security.debian.org/ stretch/updates main" >> /etc/apt/sources.list && \
    apt-get update && apt-get install -y --no-install-recommends \
    gcc g++ make build-essential wget curl unzip tar bzip2 \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /usr/src/app

# Upgrade GLIBC to 2.27
RUN wget http://ftp.gnu.org/gnu/libc/glibc-2.27.tar.gz && \
    tar -xvzf glibc-2.27.tar.gz && \
    cd glibc-2.27 && \
    mkdir build && cd build && \
    ../configure --prefix=/opt/glibc-2.27 && \
    make -j$(nproc) && make install && \
    cd ../.. && rm -rf glibc-2.27 glibc-2.27.tar.gz

# Set new GLIBC as default
ENV LD_LIBRARY_PATH=/opt/glibc-2.27/lib:$LD_LIBRARY_PATH

# Verify installations
RUN mvn -version && gcc --version && make --version && ldd --version

CMD ["mvn", "-version"]
