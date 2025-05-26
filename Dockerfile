# --------------------
# Stage 1: Build Stage
# --------------------
FROM node:current-slim AS build

# Set working directory
WORKDIR /app

# Install dependencies separately to leverage caching
COPY package*.json ./
RUN npm install

# Copy source code
COPY . .

# Build the production-ready static files
RUN npm run build

# ----------------------------
# Stage 2: Production Stage
# ----------------------------
FROM nginx:stable-alpine AS production

# Remove default nginx static assets
RUN rm -rf /usr/share/nginx/html/*

# Copy built assets from build stage
COPY --from=build /app/dist /usr/share/nginx/html

# Copy custom nginx config if you have one (optional)
# COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80 (HTTP)
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
