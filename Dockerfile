# Use an official Node runtime as a parent image
FROM node:14

# Set the working directory in the container
WORKDIR /app

# Install system dependencies including 'tree' and 'git'
RUN apt-get update && \
    apt-get install -y tree git

# After setting WORKDIR and before CMD
ENV CODEBASE_PATH=/app


# Copy package.json and package-lock.json separately to leverage Docker caching
COPY package*.json ./

# Install dependencies
RUN npm install


# Install ts-node globally
RUN npm install -g ts-node

# Copy the rest of your application's code into the container
COPY . .

# Expose the port on which your application runs
EXPOSE 3000

# Command to run your app
CMD ["ts-node", "src/server.ts"]
