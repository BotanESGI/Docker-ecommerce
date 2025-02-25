# Étape de base commune
FROM node:18-alpine AS base
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
WORKDIR /app
COPY package.json ./
COPY . .

# Étape de développement
FROM base AS development
RUN npm install && npm cache clean --force \
    && chown -R appuser:appgroup /app
USER appuser
ENV NODE_ENV=development
EXPOSE 3002
CMD ["npm", "run", "dev"]

# Étape de production
FROM base AS production
RUN npm install --omit=dev && npm cache clean --force \
    && chown -R appuser:appgroup /app
USER appuser
ENV NODE_ENV=production
ENV JWT_SECRET_FILE=/run/secrets/jwt_secret
EXPOSE 3002
CMD ["node", "src/app.js"]
