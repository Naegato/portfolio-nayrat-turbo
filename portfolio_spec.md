# 🚀 Spécifications Techniques : Projet Portfolio Monorepo

Ce document détaille l'architecture et la configuration du projet de portfolio, conçu pour être performant, scalable et facile à maintenir grâce à une approche monorepo.

## 🏗️ Architecture Globale (Turborepo)

Le projet utilise **Turborepo** pour orchestrer le monorepo. Cette structure permet de partager des configurations (ESLint, Prettier, TypeScript) et de gérer les builds de manière optimisée.

### Structure des dossiers
```text
/
├── apps/
│   ├── front/          # Application Next.js
│   └── content/        # Instance Strapi 5
├── packages/
│   ├── docker/         # Orchestration (Docker Compose, Dockerfiles)
│   ├── config-eslint/  # Configuration de linting partagée
│   └── config-typescript/ # Configuration TS partagée
├── turbo.json          # Configuration du pipeline Turborepo
└── package.json        # Dépendances racine
```

---

## 🟢 Backend : Strapi 5 (`apps/content`)

Strapi 5 sert de CMS Headless (Content Management System) pour gérer les projets, les compétences et les textes du portfolio.

- **Nom de l'app** : `content`
- **Technologie** : Strapi 5
- **Base de données** : PostgreSQL (via Docker)
- **Fonctionnalités clés** :
  - Content Types : Projets, Catégories, Témoignages, À propos.
  - API REST/GraphQL sécurisée par tokens.
  - Gestion des médias (Images, PDF).

---

## 🔵 Frontend : Next.js (`apps/front`)

Le front-end est une application moderne optimisée pour le SEO et la performance.

- **Nom de l'app** : `front`
- **Framework** : Next.js (App Router)
- **Stylisation** : Tailwind CSS
- **Récupération de données** : Fetch depuis l'API Strapi (Server-side rendering / Static Generation).
- **Points forts** :
  - Optimisation des images (Next/Image).
  - Animations fluides (Framer Motion).
  - Design Responsive "Mobile First".

---

## 🐳 Infrastructure : Docker (`packages/docker`)

La conteneurisation permet d'isoler l'environnement de développement et de faciliter le déploiement.

- **Services inclus** :
  - `strapi_db` : Image PostgreSQL.
  - `strapi_app` : Image personnalisée pour l'instance Strapi.
- **Utilisation** :
  - Le package contient un `docker-compose.yml` permettant de lancer l'écosystème backend en une commande.
  - Configuration via variables d'environnement (`.env`).

---

## 🛠️ Workflow de Développement

1. **Installation** : `npm install` à la racine.
2. **Lancement du backend** : `cd packages/docker && docker-compose up -d`.
3. **Lancement du développement** : `npx turbo dev` pour lancer Strapi et Next.js simultanément avec hot-reload.
4. **Build** : `npx turbo build` pour compiler l'ensemble du monorepo.

---

## 📝 Notes pour l'Agent
- Veiller à ce que l'URL de l'API Strapi soit correctement injectée dans le `.env` du frontend.
- Utiliser les fonctionnalités de Strapi 5 (Document Service API) pour la récupération des données.
