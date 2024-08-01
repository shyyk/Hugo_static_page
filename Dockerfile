# Stage 1: Build the Hugo site
FROM klakegg/hugo:ext-alpine AS builder

# Set the working directory
WORKDIR /src

# Copy the site files into the container
COPY . .

# Build the site
RUN hugo --gc --cleanDestinationDir

# Stage 2: Serve the site with a minimal web server
FROM nginx:alpine

# Copy the built site from the builder stage
COPY --from=builder /src/public /usr/share/nginx/html

# Expose port 9898
EXPOSE 9898

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
