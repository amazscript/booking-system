.PHONY: help up down restart build logs status seed reset clean fresh dev api frontend install test

# ═══════════════════════════════════════
# Booking System — Commandes
# ═══════════════════════════════════════

help: ## Afficher l'aide
	@echo ""
	@echo "  Booking System — Commandes disponibles"
	@echo "  ═══════════════════════════════════════"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'
	@echo ""

# ─── Docker ───────────────────────────

up: ## Démarrer tous les services (Docker + MinIO)
	docker start minio 2>/dev/null || docker run -d --name minio -p 9000:9000 -p 9001:9001 -e MINIO_ROOT_USER=hotelbot -e MINIO_ROOT_PASSWORD=hotelbot_secret minio/minio server /data --console-address ":9001"
	docker compose up -d
	@echo ""
	@echo "  ✓ Frontend : http://localhost:5173"
	@echo "  ✓ API      : http://localhost:3000"
	@echo "  ✓ MinIO    : http://localhost:9001"
	@echo "  ✓ Mailpit  : http://localhost:8025"
	@echo "  ✓ PostgreSQL : localhost:5433"
	@echo ""

down: ## Arrêter tous les services
	docker compose down
	docker stop minio 2>/dev/null || true

restart: ## Redémarrer tous les services
	docker compose restart

build: ## Rebuild les images Docker
	docker compose build --no-cache

logs: ## Voir les logs (tous les services)
	docker compose logs -f

logs-api: ## Voir les logs API uniquement
	docker compose logs -f api

logs-frontend: ## Voir les logs frontend uniquement
	docker compose logs -f frontend

status: ## Statut des services
	@docker compose ps

# ─── Base de données ──────────────────

seed: ## Peupler la base avec des données de démo
	docker compose exec api node seed.js
	@echo "  ✓ Base peuplée (admin@booking.local / admin123)"

reset: ## Reset complet de la base (supprime + recrée)
	docker compose exec api node seed.js
	@echo "  ✓ Base recréée"

seed-demo: ## Peupler avec les données démo riches (6 resources, 25 bookings, images)
	docker compose exec api node seed-demo.js --clean
	@echo "  ✓ Données démo créées (6 resources, 31 champs, 25 bookings)"

reset-demo: ## Reset total + seed de base + seed démo
	docker compose exec api node seed.js
	docker compose exec api node seed-demo.js
	@echo "  ✓ Base recréée avec données démo complètes"

db-shell: ## Ouvrir un shell PostgreSQL
	docker compose exec postgres psql -U booking booking

# ─── Développement local (sans Docker) ─

dev: ## Démarrer en mode dev local (API + Frontend)
	@echo "  Démarrage API + Frontend en local..."
	@cd api && node server.js & echo "  ✓ API sur http://localhost:3000"
	@cd frontend && npx vite --host & echo "  ✓ Frontend sur http://localhost:5173"

api: ## Démarrer l'API seule (local)
	cd api && node server.js

frontend: ## Démarrer le frontend seul (local)
	cd frontend && npx vite --host

install: ## Installer les dépendances (API + Frontend)
	cd api && npm install
	cd frontend && npm install
	@echo "  ✓ Dépendances installées"

# ─── Build & Test ─────────────────────

build-frontend: ## Build le frontend pour production
	cd frontend && npx vite build
	@echo "  ✓ Frontend buildé dans frontend/dist/"

test: ## Lancer les tests API
	cd api && npm test

# ─── Nettoyage ────────────────────────

clean: ## Supprimer les volumes Docker (reset total)
	docker compose down -v --remove-orphans
	@echo "  ✓ Volumes supprimés, reset total"

clean-all: ## Supprimer images + volumes + cache
	docker compose down -v --rmi all --remove-orphans
	rm -rf api/node_modules frontend/node_modules frontend/dist api/db.sqlite
	@echo "  ✓ Tout nettoyé"

fresh: ## Reset total comme après un clone (stop + supprime tout + rebuild + seed)
	@echo "  Nettoyage complet..."
	docker compose down -v --remove-orphans 2>/dev/null || true
	docker rm -f minio 2>/dev/null || true
	docker volume rm booking_booking_pgdata 2>/dev/null || true
	rm -rf api/node_modules frontend/node_modules frontend/dist node_modules
	@echo "  Démarrage MinIO..."
	docker start minio 2>/dev/null || docker run -d --name minio -p 9000:9000 -p 9001:9001 -e MINIO_ROOT_USER=hotelbot -e MINIO_ROOT_PASSWORD=hotelbot_secret minio/minio server /data --console-address ":9001"
	@echo "  Rebuild..."
	docker compose up -d --build
	@echo "  Attente PostgreSQL..."
	@sleep 5
	docker compose exec api node seed.js
	docker compose exec api node seed-demo.js
	@echo "  Redémarrage API (connexion MinIO)..."
	docker restart booking-api
	@sleep 2
	@echo ""
	@echo "  ✓ Installation fraîche terminée"
	@echo "  ✓ Frontend : http://localhost:5173"
	@echo "  ✓ API      : http://localhost:3000"
	@echo "  ✓ MinIO    : http://localhost:9001"
	@echo "  ✓ Mailpit  : http://localhost:8025"
	@echo "  ✓ Admin    : admin@booking.local / admin123"
	@echo ""

# ─── Emails ───────────────────────────

mail: ## Ouvrir Mailpit dans le navigateur
	open http://localhost:8025

# ─── Production ───────────────────────

prod: ## Démarrer en mode production
	docker compose -f docker-compose.yml up -d --build
	@echo "  ✓ Production démarrée"
