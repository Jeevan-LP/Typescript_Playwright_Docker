# Use official Playwright image with Node.js, browsers and dependencies
FROM mcr.microsoft.com/playwright:v1.61.1-noble

# Application directory inside container
WORKDIR /app

# Copy dependency files first
COPY package.json package-lock.json ./

# Install exact project dependencies
RUN npm ci

# Copy the complete automation framework
COPY . .

# Default environment
ENV ENV_NAME=QA

# Default browser/project
ENV BROWSER=chromium

# Run Playwright tests when container starts
CMD ["npx", "playwright", "test"]