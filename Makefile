# Mes variables
DOCKER_COMPOSE = docker-compose
DEV_FILE = docker-compose.yml
PROD_FILE = docker-compose.prod.yml

# Mes commandes
.PHONY: help up-dev up-prod down-dev down-prod logs-dev logs-prod rebuild-dev rebuild-prod restart-dev restart-prod status clean install-product run-tests build-prod

## Afficher les commandes disponibles
help:
	@echo ""
	@echo "🚀 \033[1;32mCommandes Makefile disponibles\033[0m 🚀"
	@echo "---------------------------------------------"
	@echo "\033[1;34mDémarrage et Arrêt :\033[0m"
	@echo "  make up-dev       → Lancer le projet en mode développement"
	@echo "  make up-prod      → Lancer le projet en mode production"
	@echo "  make down-dev     → Arrêter le projet en mode développement"
	@echo "  make down-prod    → Arrêter le projet en mode production"
	@echo ""
	@echo "\033[1;34mLogs et Statut :\033[0m"
	@echo "  make logs-dev     → Afficher les logs du projet en mode développement"
	@echo "  make logs-prod    → Afficher les logs du projet en mode production"
	@echo "  make status       → Voir les services Docker actifs"
	@echo ""
	@echo "\033[1;34mRebuild et Restart :\033[0m"
	@echo "  make rebuild-dev  → Rebuild et redémarrer en mode développement"
	@echo "  make rebuild-prod → Rebuild et redémarrer en mode production"
	@echo "  make restart-dev  → Redémarrer les services en mode développement"
	@echo "  make restart-prod → Redémarrer les services en mode production"
	@echo ""
	@echo "\033[1;34mMaintenance :\033[0m"
	@echo "  make clean        → Supprimer les conteneurs, images et volumes inutilisés"
	@echo ""
	@echo "\033[1;34mScript :\033[0m"
	@echo "  make install-product → Exécuter le script d'initialisation des produits"
	@echo "  make run-tests       → Exécuter le script des tests du projet"
	@echo ""
	@echo "\033[1;34mGestion des images :\033[0m"
	@echo "  make build-prod   → Construire les images Docker pour la production"
	@echo ""

## Lancer le projet en mode développement
up-dev:
	$(DOCKER_COMPOSE) -f $(DEV_FILE) up --build -d

## Lancer le projet en mode production
up-prod:
	docker build -t auth-service:latest ./services/auth-service
	docker build -t order-service:latest ./services/order-service
	docker build -t product-service:latest ./services/product-service
	docker build -t frontend:latest ./frontend
	$(DOCKER_COMPOSE) -f $(PROD_FILE) up --build -d

## Arrêter le projet en mode développement
down-dev:
	$(DOCKER_COMPOSE) -f $(DEV_FILE) down

## Arrêter le projet en mode production
down-prod:
	$(DOCKER_COMPOSE) -f $(PROD_FILE) down

## Afficher les logs du projet en mode développement
logs-dev:
	$(DOCKER_COMPOSE) -f $(DEV_FILE) logs -f

## Afficher les logs du projet en mode production
logs-prod:
	$(DOCKER_COMPOSE) -f $(PROD_FILE) logs -f

## Rebuild les images et redémarrer en mode développement
rebuild-dev:
	$(DOCKER_COMPOSE) -f $(DEV_FILE) up --build -d --force-recreate

## Rebuild les images et redémarrer en mode production
rebuild-prod:
	$(DOCKER_COMPOSE) -f $(PROD_FILE) up --build -d --force-recreate

## Redémarrer les services en mode développement
restart-dev:
	$(DOCKER_COMPOSE) -f $(DEV_FILE) restart

## Redémarrer les services en mode production
restart-prod:
	$(DOCKER_COMPOSE) -f $(PROD_FILE) restart

## Afficher l'état des conteneurs en cours d'exécution
status:
	$(DOCKER_COMPOSE) ps

## Nettoyer les conteneurs, images et volumes inutilisés
clean:
	@echo "🧹 Suppression des conteneurs arrêtés, images et volumes inutilisés..."
	docker system prune -f --volumes

## Construire les images Docker pour la production
build-prod:
	@echo "⚙️  Construction des images Docker pour la production..."
	docker build -t auth-service:latest ./services/auth-service
	docker build -t order-service:latest ./services/order-service
	docker build -t product-service:latest ./services/product-service
	docker build -t frontend:latest ./frontend
	@echo "✅ Build terminé !"

## Exécuter le script d'initialisation des produits
install-product:
	@echo "📦 Initialisation des produits..."
	./scripts/init-products.sh

## Exécuter les tests du projet
run-tests:
	@echo "🧪 Exécution des tests..."
	./scripts/run-tests.sh
