FROM debian:buster-slim
LABEL maintainer "https://github.com/weiji14"
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

# Install standard dependencies a la buildpack-deps curl https://hub.docker.com/_/buildpack-deps/
RUN apt-get -qq update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    gnupg2 \
    && rm -rf /var/lib/apt/lists/*

ENV NODE_VERSION=8

# Get node source as per https://github.com/nodesource/distributions#installation-instructions
# Install npm and update it to the latest version
RUN curl -sL https://deb.nodesource.com/setup_$NODE_VERSION.x | bash - \
    && apt-get -qq update \
    && apt-get install -y --no-install-recommends nodejs \
    && rm -rf /var/lib/apt/lists/*

# Build and install dat and dependencies using npm https://github.com/datproject/dat
RUN npm install -g dat

# Setup dat user and workdir
RUN useradd -d /home/dat -m dat
USER dat
WORKDIR /home/dat

# Expose Dat's default port https://github.com/datproject/dat/issues/588
# See also https://github.com/joehand/dat-doctor/blob/master/index.js
# Try also running DEBUG=dat* dat doctor
EXPOSE 3282
EXPOSE 8887

# Set dat command as docker run entrypoint
#ENTRYPOINT ["dat"]
CMD ["dat"]
