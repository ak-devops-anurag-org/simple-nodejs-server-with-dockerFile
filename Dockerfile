# Use a smaller official Node.js image
FROM node:current-slim

# Set working directory
WORKDIR /app

# Copy only package files first to leverage Docker cache
COPY package*.json ./

# Install dependencies (full install since it's for development)
RUN npm install

# Copy the rest of your source code
COPY . .

# Expose Vite's default dev server port
EXPOSE 5173

# Start the Vite dev server, bind to all interfaces for hot reload
CMD ["npm", "run", "dev", "--", "--host"]
