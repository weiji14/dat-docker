FROM debian:buster-slim
LABEL maintainer "https://github.com/weiji14"
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV NODE_VERSION=8

# Get dat source files and dependencies https://github.com/datproject/dat
RUN apt-get -qq update && apt-get install -y --no-install-recommends \
    # Curl related dependencies
    ca-certificates \
    curl \
    gnupg \

    # Get node source as per https://github.com/nodesource/distributions#installation-instructions
    && curl -sL https://deb.nodesource.com/setup_$NODE_VERSION.x | bash - \

    # Install npm and update it to the latest version
    && apt-get install -y --no-install-recommends nodejs \

    # Build and install dat using npm
    && npm install -g dat \

    # Remove unneeded build dependencies
    && apt-get remove -y \
    curl \
    gnupg \

    # More purging
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

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
