# Use a newer Puppeteer image to get a compatible Node.js version and security updates
FROM ghcr.io/puppeteer/puppeteer:24.9.0

# Environment variables from the original file
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/google-chrome-stable

# Set the working directory
WORKDIR /usr/src/app

# --- FIX ---
# Before copying files, change the ownership of the app directory to the non-root 'pptruser'.
# This gives npm the permission it needs to write the package-lock.json and node_modules.
# The 'pptruser' is the default user in this base image.
RUN chown -R pptruser:pptruser /usr/src/app

# Copy package files
COPY package*.json ./

# Run npm install as the non-root user
RUN npm install

# Copy the rest of the application code
COPY . .

# Command to run the application
CMD [ "node", "index.js" ]
