# Use an official Node runtime as a parent image
FROM node:18-alpine

# Create app directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json first (for better caching)
COPY package*.json ./

# Install app dependencies
RUN npm ci --only=production

# Copy application source
COPY . .

# Expose port the app listens on
EXPOSE 3000

# Start the app
CMD ["node", "app.js"]
