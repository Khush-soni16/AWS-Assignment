<<<<<<< HEAD
# Stage 1: Build
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install --production
COPY . .

# Stage 2: Production image
FROM node:20-alpine
WORKDIR /app
COPY --from=builder /app /app

# Create non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

EXPOSE 3000
CMD ["node", "app.js"]
=======
# Stage 1: Build
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install --production
COPY . .

# Stage 2: Production image
FROM node:20-alpine
WORKDIR /app
COPY --from=builder /app /app

# Create non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

EXPOSE 3000
CMD ["node", "app.js"]
>>>>>>> 740f6f82da195478be39992633b6362713aaa904
