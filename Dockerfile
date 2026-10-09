# FROM defines the base image for our Docker image. Here I'm using the official 
Playwright 1.61.1 image, which provides Node.js, Playwright browsers, and their required dependencies.
FROM mcr.microsoft.com/playwright:v1.61.1-noble

# Creates/sets /app as the working directory inside the container.
WORKDIR /app

# Copies the two dependency files from your local project into /app inside the container.
COPY package.json package-lock.json ./

# RUN executes a command while building the Docker image. Here, npm ci installs the exact 
Node.js dependencies defined in package-lock.json.
RUN npm ci

# Copies the remaining project files from your local project into /app.
COPY . .

# Creates an environment variable inside the Docker container.
ENV ENV_NAME=QA

# Default browser/project
ENV BROWSER=chromium

# CMD defines the default command that runs when the Docker container starts. 
In my case, it executes the Playwright test suite."
CMD ["npx", "playwright", "test"]

# Complete flow

# FROM
#   ↓
# Get Playwright + Node.js + browsers
#   ↓
# WORKDIR
#   ↓
# Create/use /app
#   ↓
# COPY package.json + package-lock.json
#   ↓
# RUN npm ci
#   ↓
# Install project dependencies
#   ↓
# COPY . .
#   ↓
# Copy Playwright framework
#   ↓
# ENV ENV_NAME=QA
#   ↓
# Set QA environment
#   ↓
# ENV BROWSER=chromium
#   ↓
# Set Chromium as default browser
#   ↓
# CMD
#   ↓
# Run "npx playwright test"
