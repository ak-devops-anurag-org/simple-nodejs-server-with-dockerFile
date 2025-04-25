# Use an official Node.js image for development (base IMAGE)
FROM node:current

# Set the working directory inside the container
WORKDIR /app

# Copy the package.json and package-lock.json (or yarn.lock) into the container
COPY package*.json ./

# Install dependencies inside the container
RUN npm install

# Copy the rest of the application code into the container
COPY . .

# Expose Vite's default port
EXPOSE 5173

# Start the React development server (automatically reloads when code changes)
# CMD ["npm","run","dev"]
CMD ["npm", "run", "dev", "--", "--host"]

