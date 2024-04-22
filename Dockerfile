FROM node:12

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

RUN apt-get update && apt-get install -y \
    build-essential \
    zlib1g-dev \
    libncurses5-dev \
    libgdbm-dev \
    libnss3-dev \
    libssl-dev \
    libsqlite3-dev \
    libreadline-dev \
    libffi-dev \
    wget \
    libbz2-dev

RUN wget https://www.python.org/ftp/python/3.7.4/Python-3.7.4.tgz && \
    tar -xf Python-3.7.4.tgz && \
    cd Python-3.7.4 && \
    ./configure --enable-optimizations && \
    make -j$(nproc) && \
    sudo make altinstall

RUN npm install

# Bundle app source
COPY . .

EXPOSE 8080
CMD [ "npm", "run", "dev" ]
