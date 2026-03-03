requirement:
	@echo "Checking for pnpm..."
	@command -v pnpm >/dev/null 2>&1 || { echo >&2 "pnpm is required but it's not installed. Please install pnpm first."; exit 1; }

up: install
	pnpm dev; $(MAKE) down

down:
	cd packages/docker && docker compose down

install: requirement
	@echo "Installing dependencies..."
	pnpm install