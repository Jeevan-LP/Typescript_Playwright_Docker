# Purpose: Contains instructions to build your Docker image.
# What it does:
# - Selects the Playwright base image.
# - Creates the working directory.
# - Installs Node.js dependencies.
# - Copies your project files.
# - Defines the default test execution command.

#===============================================================================================================
# Only if there is a docker-compose.yml and docker-entrypoint.sh files
#===============================================================================================================
FROM mcr.microsoft.com/playwright:v1.61.1-noble
 
# Working folder inside the container
WORKDIR /app
 
# Copy dependency files first (faster rebuilds), then install
COPY package.json package-lock.json ./
RUN npm ci
 
# Copy the rest of the project
COPY . .
 
# Fix Windows line endings (CRLF -> LF) and make the entrypoint runnable
RUN sed -i 's/\r$//' ./docker-entrypoint.sh && chmod +x ./docker-entrypoint.sh
 
# Default settings (docker-compose.yml can override these)
ENV ENV_NAME=QA
ENV BROWSER=chromium
 
# 1) The entrypoint script always runs first
ENTRYPOINT ["./docker-entrypoint.sh"]
 
# 2) CMD is the default command passed to the entrypoint
CMD ["npx", "playwright", "test"]

# Complete flow
#
# FROM                      -> Get Playwright + Node.js + browsers
# WORKDIR                   -> Create/use /app
# COPY package*.json        -> Copy dependency files
# RUN npm ci                -> Install project dependencies
# COPY . .                  -> Copy Playwright framework
# ENV ENV_NAME=QA           -> Set QA environment
# ENV BROWSER=chromium      -> Set Chromium as default browser

# #===============================================================================================================
# # Only if there is no docker-compose.yml and docker-entrypoint.sh files
# #===============================================================================================================
# # FROM defines the base image for our Docker image. Here I'm using the official Playwright 1.61.1 image, 
# # which provides Node.js, Playwright browsers, and their required dependencies.
# FROM mcr.microsoft.com/playwright:v1.61.1-noble

# # Creates/sets /app as the working directory inside the container.
# WORKDIR /app

# # Copies the two dependency files from your local project into /app inside the container.
# COPY package.json package-lock.json ./

# # RUN executes a command while building the Docker image. Here, npm ci installs the exact Node.js dependencies defined in package-lock.json.
# RUN npm ci

# # Copies the remaining project files from your local project into /app.
# COPY . .

# # Creates an environment variable inside the Docker container.
# ENV ENV_NAME=QA

# # Default browser/project
# ENV BROWSER=chromium

# # CMD defines the default command that runs when the Docker container starts.In my case, it executes the Playwright test suite.
# CMD ["npx", "playwright", "test"]

# # ------------------------------------------------------------------------------
# #  PLAYWRIGHT SCRIPT  ->  DOCKER   (read left to right, row by row)
# # ------------------------------------------------------------------------------
# #
# #  STEP A: BUILD THE IMAGE (once)    docker build -t playwright-docker-project .
# #
# #  +-----------+    +-----------+    +-----------+    +-----------+    +-----------+
# #  | 1. Script |    |  2. FROM  |    | 3. WORKDIR|    |  4. COPY  |    |   5. RUN  |
# #  | Playwright| -> |  browsers | -> |    /app   | -> | pkg files | -> |   npm ci  |
# #  +-----------+    +-----------+    +-----------+    +-----------+    +-----------+
# #                                                                            |
# #        +-------------------------------------------------------------------+
# #        v
# #  +-----------+    +-----------+    +-----------+    +-----------+    +-----------+
# #  |  6. COPY  |    |   7. ENV  |    |   8. ENV  |    |   9. CMD  |    |   IMAGE   |
# #  | code+tests| -> |     QA    | -> |  chromium | -> | run tests | -> |   READY   |
# #  +-----------+    +-----------+    +-----------+    +-----------+    +-----------+
# #
# # ------------------------------------------------------------------------------
# #
# #  STEP B: RUN THE TESTS (every time) docker run --rm <<docker image name/id which given by you>
# #
# #  +-----------+    +-----------+    +-----------+    +-----------+    +-----------+
# #  |   Image   |    | docker run|    | Container |    |    npx    |    |  Removed  |
# #  |           | -> |           | -> |   starts  | -> | playwright| -> |   (--rm)  |
# #  |           |    |           |    |           |    |    test   |    |           |
# #  +-----------+    +-----------+    +-----------+    +-----------+    +-----------+
# #
# #  Build once. Run many times. Rebuild only if code or dependencies change.