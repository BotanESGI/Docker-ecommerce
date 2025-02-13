# 1 : Construction
FROM node:18-alpine AS build
WORKDIR /app

# Copier et Installer les dépendances
COPY package*.json ./
RUN npm install

COPY . .
EXPOSE 3001
CMD ["npm", "start"]
