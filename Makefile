SHELL := /usr/bin/env bash
.DEFAULT_GOAL := help
GIT := $(shell command -v git 2>/dev/null || true)

.PHONY: help chx setup run install status

help: ## Show available make targets.
	@printf "Usage: make [target]\n\n"
	@printf "Targets:\n"
	@awk 'BEGIN {FS = ":.*##"} /^[a-zA-Z0-9_-]+:.*##/ { printf "  %-12s %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

chx: ## Make the setup script executable.
	@chmod u+x ./setup.sh
	@printf "setup.sh is executable\n"

setup: chx ## Install symlinks for dotfiles.
	@bash ./setup.sh

run: ## Run the setup script directly.
	@bash ./setup.sh

install: setup ## Alias for setup.
	@printf "Install complete.\n"

status: ## Show git status for the repo.
ifndef GIT
	@echo "Git is not installed or not available in PATH."
else
	@git status --short
endif
