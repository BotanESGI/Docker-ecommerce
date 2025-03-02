# 🛒 Projet Docker E-Commerce Microservices

## 📌 Introduction
Ce projet vise à concevoir une infrastructure **Docker** complète pour une application **e-commerce** basée sur une architecture **microservices**. Il inclut des **bonnes pratiques de conteneurisation**, l'orchestration avec **Docker Compose**, et en option, **Docker Swarm**.

---

## ⚙️ Prérequis & Documentation

Avant de commencer, assurez-vous d'avoir les outils suivants installés Docker

- [Documentation Docker](https://www.docker.com/) (Prérequis)
- [Documentation Docker Compose](https://docs.docker.com/compose/)
- [Documentation Docker Swarm](https://docs.docker.com/engine/swarm/)

---

## 🏗 Architecture du Projet
L'application est divisée en plusieurs **services indépendants** :

- **auth-service** : Gestion de l'authentification et des utilisateurs.
- **order-service** : Gestion des commandes et des transactions.
- **product-service** : Gestion des produits du catalogue.
- **mongodb** : Base de données **MongoDB** utilisée pour stocker les informations des services.
- **frontend** : Interface utilisateur servie par **Nginx**.

---

## 🌍 Configuration des Environnements
Les variables d'environnement sont définies dans des fichier `.env`.

- `.env.development` pour le développement
- `.env.production` pour la production

Exemple de fichier `.env` :

```code
VITE_PRODUCT_SERVICE_URL=http://product-service:3000
VITE_AUTH_SERVICE_URL=http://auth-service:3001
VITE_ORDER_SERVICE_URL=http://order-service:3002
JWT_SECRET=efrei_super_pass
MONGODB_URI=mongodb://mongodb:27017
```

---

## 🚀 Déploiement en Développement

Pour un déploiement **sécurisé et optimisé** en local, utilisez la commande suivante :

```sh
docker-compose -f docker-compose.yml up --build -d
```

### 📌 Explication des options utilisées

| Option | Description |
|--------|------------|
| `-f docker-compose.prod.yml` | Spécifie un fichier `docker-compose` particulier (ici, `docker-compose.prod.yml`), différent du fichier par défaut `docker-compose.yml`. Cela permet d'utiliser une configuration adaptée à la production (optimisation des images, gestion des logs, etc.). |
| `up` | Démarre les conteneurs définis dans le fichier de configuration. |
| `-d` (detached mode) | Exécute les conteneurs en arrière-plan, sans bloquer le terminal. |
| `--build` | Reconstruit les images Docker avant de démarrer les services, garantissant que les dernières modifications du code ou de la configuration sont prises en compte. |
---

## 🌐 Déploiement en Production

Pour un déploiement **sécurisé et optimisé** en production, utilisez les commandes suivante :

pour construire les images en local
```sh
docker build -t auth-service:latest ./services/auth-service
docker build -t order-service:latest ./services/order-service
docker build -t product-service:latest ./services/product-service
docker build -t frontend:latest ./frontend
```

puis pour lancez les services

```sh
docker-compose -f docker-compose.prod.yml up --build -d
```

### 📌 Explication des options utilisées

| Option | Description |
|--------|------------|
| `-f docker-compose.prod.yml` | Spécifie un fichier `docker-compose` particulier (ici, `docker-compose.prod.yml`), différent du fichier par défaut `docker-compose.yml`. Cela permet d'utiliser une configuration adaptée à la production (optimisation des images, gestion des logs, etc.). |
| `up` | Démarre les conteneurs définis dans le fichier de configuration. |
| `-d` (detached mode) | Exécute les conteneurs en arrière-plan, sans bloquer le terminal. |
| `--build` | Reconstruit les images Docker avant de démarrer les services, garantissant que les dernières modifications du code ou de la configuration sont prises en compte. |
---

## 🔍 Test des Services
Utilisez les commandes suivantes pour tester les services :

```sh
# Tester la santé du service d'authentification
curl http://localhost:3001/api/health

# Tester la santé du service de gestion des commandes
curl http://localhost:3002/api/health

# Tester la santé du service de gestion des produits
curl http://localhost:3000/api/health

# Tester la connexion à MongoDB
docker exec -it docker-ecommerce-mongodb-1 mongosh --eval "db.runCommand({ ping: 1 })"

```

---

## 🛠 Makefile - Gestion Simplifiée
Un **Makefile** est inclus pour faciliter l'exécution des commandes Docker.  
Vous pouvez afficher les commandes disponibles en exécutant :

```sh
make help
```

### 📜 Exemples de commandes Makefile :
- **Lancer l'environnement de développement** :
  ```sh
  make up-dev
  ```
- **Lancer l'environnement de production** :
  ```sh
  make up-prod
  ```
- **Arrêter les services** :
  ```sh
  make down-dev
  make down-prod
  ```
- **Vérifier les logs** :
  ```sh
  make logs-dev
  make logs-prod
  ```
- **Nettoyage** :
  ```sh
  make clean
  ```

---

## Bonnes Pratiques Docker Compose

### Bonnes Pratiques Générales

1. **Architecture Microservices**:
    - Chaque service est **indépendant** et peut être déployé et géré séparément.
    - Utilisation de **API REST** pour la communication entre les services.

2. **Optimisation des Images Docker**:
    - Utilisation de **multi-stage builds** pour réduire la taille des images.
    - Inclusion d'un fichier **.dockerignore** pour exclure les fichiers inutiles lors de la construction des images.
    - Utilisation de l'image node:18-alpine pour réduire la taille de l'image avec une base plus légère.
    - Définition de NODE_ENV à development ou production selon l’étape pour gérer facilement la configuration.
    - État de développement et de production séparés : Gestion des dépendances optimisée avec des installations spécifiques à chaque environnement.
    - Nettoyage du cache npm : Utilisation de npm cache clean --force après chaque installation pour réduire la taille de l'image et améliorer la sécurité.
    - Exposition des ports pour gérer correctement les conteneurs via les ports.

3. **Sécurité**:
    - Exécution des conteneurs avec un **utilisateur non-root** pour limiter les privilèges.
    - Gestion des **secrets** via des fichiers `.env`, qui ne doivent pas être versionnés en production.
    - Utilisation de **scan de vulnérabilités** sur les images Docker pour détecter les failles de sécurité.
    - Utilisation de chown -R appuser:appgroup /app pour garantir que les fichiers appartiennent à un utilisateur non-root.
    - Exclusion du .env.production de github pour éviter de partager des informations sensibles.

### Logging et Monitoring

4. **Centralisation des Logs**:
    - Configuration des logs avec le pilote `json-file`, limitant la taille et le nombre de fichiers pour éviter une utilisation excessive de l'espace disque.

5. **Healthchecks**:
    - Implémentation de **healthchecks** pour chaque service afin de surveiller leur état de fonctionnement et d'assurer leur disponibilité.

### Configuration des Services

6. **Gestion des Dépendances**:
    - Utilisation de `depends_on` pour spécifier les dépendances entre services, garantissant que les services nécessaires sont disponibles avant le démarrage des autres.

7. **Ressources Limitées**:
    - Limitation des ressources CPU et mémoire pour chaque service, ce qui aide à éviter la surcharge des ressources du système.

8. **Volumes pour Persistance**:
    - Utilisation de volumes Docker pour la persistance des données (par exemple, `mongo-data` pour MongoDB).

### Réseau

9. **Isolation des Réseaux**:
    - Création d'un réseau personnalisé (`app-network`) pour l'isolation des services et la gestion de la communication interne.

### Développement

10. **Environnements de Développement**:
    - Utilisation de fichiers `.env.development` et `.env.production` pour la configuration spécifique à l'environnement, permettant une gestion facile des variables d'environnement.

### Résilience

11. **Redémarrage Automatique**:
    - Configuration du redémarrage automatique des services avec `restart: always` pour assurer la continuité de service en cas d'échec.

