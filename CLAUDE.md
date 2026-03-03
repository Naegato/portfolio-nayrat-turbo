# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Portfolio monorepo using **Turborepo** with pnpm workspaces. The project has two planned apps:
- `apps/front/` — Next.js frontend (App Router, Tailwind CSS, Framer Motion)
- `apps/content/` — Strapi 5 headless CMS (PostgreSQL backend)

Shared packages live under `packages/` (eslint config, typescript config, Docker orchestration).

## Commands

```bash
# Setup
make install          # Check pnpm, install deps
pnpm install          # Install dependencies directly

# Development
pnpm dev              # Run all apps in dev mode (turbo)
make up               # Install + dev in one step

# Build & Quality
pnpm build            # Build all apps
pnpm lint             # ESLint (flat config, ESLint 9.x)
pnpm check-types      # TypeScript type checking
pnpm format           # Prettier formatting

# Filter to single app
turbo dev --filter=front
turbo build --filter=content
```

## Tech Stack & Config

- **Package manager**: pnpm 9.0.0 (workspace protocol `workspace:*` for internal deps)
- **Node**: >=18
- **TypeScript**: 5.9.2, strict mode, ES2022 target
- **ESLint**: 9.x flat config system (no `.eslintrc`). Config chain: `base.js` → `next.js` or `react-internal.js`
- **Next.js**: 16.x with App Router
- **Strapi**: v5, uses Document Service API for data fetching

## Architecture Notes

- Turbo pipeline: `build` has topological deps (`^build`), `dev` is persistent/uncached
- Build outputs cached: `.next/**` (excluding `.next/cache/**`)
- `.env*` files are included in build task inputs (cache-busted on env changes)
- Frontend fetches data from Strapi API — the API URL must be set in the frontend `.env`
- Docker setup (`packages/docker/`) orchestrates PostgreSQL + Strapi containers
- The spec is written in French — see `portfolio_spec.md` for full project specifications
