# Use a more recent Puppeteer image which includes a newer version of Node.js
FROM ghcr.io/puppeteer/puppeteer:22.12.1

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/google-chrome-stable

WORKDIR /usr/src/app

COPY package*.json ./
# Use 'npm install' which is more flexible than 'npm ci' for resolving dependency mismatches.
# This will also update the lock file if necessary during the build.
RUN npm install
COPY . .
CMD [ "node", "index.js" ]
