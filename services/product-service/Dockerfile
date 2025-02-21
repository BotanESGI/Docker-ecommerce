# 1 : Construction
FROM node:18-alpine AS build
WORKDIR /app

# Copier et Installer les dépendances
COPY package*.json ./
RUN npm install --production

# Copier le code source
COPY . .

# Exposer le port 3000 (mentionné dans app.js)
EXPOSE 3000

# Démarrer l'application
CMD ["npm", "start"]
