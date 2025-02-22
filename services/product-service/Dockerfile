# Étape de base commune
FROM node:18-alpine AS base
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
WORKDIR /app
COPY package*.json ./

# Étape de développement
FROM base AS development
RUN npm install && npm cache clean --force \
    && chown -R appuser:appgroup /app
COPY . .
USER appuser
ENV NODE_ENV=development
EXPOSE 3000
CMD ["npm", "run", "dev"]

# Étape de production
FROM base AS production
RUN npm install --only=production && npm cache clean --force \
    && chown -R appuser:appgroup /app
COPY . .
USER appuser
ENV NODE_ENV=production
EXPOSE 3000
CMD ["npm", "start"]
