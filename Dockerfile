FROM centos:7

ENV FLAVOR=rpmbuild OS=centos DIST=el7

# Create a dedicated working directory
WORKDIR /app

# Copy all files into the working directory
COPY . /app

# Install required packages
RUN yum install -y rpm-build rpmdevtools gcc make coreutils python \
    && yum -y clean all

# Download, extract, and install Node.js
RUN curl -O https://nodejs.org/dist/v12.19.1/node-v12.19.1-linux-x64.tar.xz \
    && tar --strip-components 1 -xvf node-v* -C /usr/local

# Change to the app directory
WORKDIR /app

# Install Node.js dependencies
RUN npm install --production

ENTRYPOINT ["node", "/app/lib/main.js"]
