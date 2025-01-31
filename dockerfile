FROM maven:3.6.0-jdk-8

# Set working directory
WORKDIR /usr/src/app

# Install required dependencies
RUN apt-get update && apt-get install -y \
    wget \
    bzip2 \
    build-essential

# Download and Install GLIBC 2.27
RUN wget http://ftp.gnu.org/gnu/libc/glibc-2.27.tar.gz && \
    tar -xvzf glibc-2.27.tar.gz && \
    cd glibc-2.27 && \
    mkdir build && cd build && \
    ../configure --prefix=/opt/glibc-2.27 && \
    make -j$(nproc) && make install && \
    cd ../.. && rm -rf glibc-2.27 glibc-2.27.tar.gz

# Set new GLIBC as default
ENV LD_LIBRARY_PATH=/opt/glibc-2.27/lib:$LD_LIBRARY_PATH

# Verify the GLIBC version
RUN ldd --version

CMD ["mvn", "-version"]
