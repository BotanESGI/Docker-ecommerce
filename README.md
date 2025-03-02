# Docker-ecommerce
### Introduction :

Ce projet vise à concevoir une infrastructure Docker complète pour une application e-commerce basée sur une architecture microservices. Il inclut des bonnes pratiques de conteneurisation, l'orchestration avec Docker Compose et, en option Docker Swarm.

### Prérequis :
- Docker
- Docker Compose
- Docker Swarm (Optionnel)
  
 ###  CArchitecture du projet :
L'application est divisée en plusieurs services indépendants :
  -auth-service : Gestion de l'authentification et des utilisateurs.
  -order-service : Gestion des commandes et des transactions.
  -product-service : Gestion des produits du catalogue.
  -mongodb : Base de données NoSQL utilisée pour stocker les informations des services.
  -frontend : Interface utilisateur, servie par un serveur web Nginx.
  
###  Configuration des environnements :
Les variables d'environnement sont définies dans `.env`. Elles permettent d'adapter le projet à différents environnements (développement, production).
Exemple de `.env`:
```sh
DB_HOST=db
DB_USER=root
DB_PASSWORD=example
JWT_SECRET=supersecretkey
 ```

### Construction et exécution des conteneurs :
  ### 1. Construire les images Docker (avec multi-stage pour optimiser la taille) :
  ```sh
  docker-compose build
   ```
  ### 2. Démarrer les conteneurs  :
  ```sh
  docker-compose up -d
   ```
  ### 3. Vérifier les logs  :
   ```sh
  docker-compose logs -f
   ```
  ### 4. Arrêter l'application :
  ```sh
  docker-compose down
 ```
###  Déploiement en production :
Pour un déploiement sécurisé et optimisé, utilisez docker-compose.prod.yml :
```sh
docker-compose -f docker-compose.prod.yml up -d --build
```
###  Test des services :
Utilisez curl  pour tester les API.
```sh
curl -X GET http://localhost:3000/api/products
```
###  Bonnes pratiques appliquées :  
- Séparation des services:
  - Architecture basée sur des microservices indépendants (produits, utilisateurs, panier).
- Optimisation des images Docker:
  -  Utilisation du multi-stage build pour réduire la taille des images Docker
- Sécurité renforcée :
  - Exécuter les conteneurs avec un utilisateur non-root
  - Gestion des secrets via .env
- Logging et monitoring :
  - Centralisation des logs
- Healthchecks :
  - Chaque service dispose d'un healthcheck permettant de s'assurer qu'il est bien opérationnel





