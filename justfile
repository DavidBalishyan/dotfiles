# Runs `help`
default: help

# Show available just commands.
help:
	@just --list
	@echo ""
	@echo "Use 'just <task>' to run a target."

# Make the setup script executable.
chx:
	chmod u+x ./setup.sh

# Run the setup script directly.
run:
	bash ./setup.sh

# Install dotfiles by running setup.
setup:
	bash ./setup.sh

# Alias for setup.
install: setup

# Optional Homebrew package installation; not required for dotfiles.
brew:
	@if command -v brew >/dev/null 2>&1; then \
		brew bundle --file=Brewfile; \
	else \
		echo "Homebrew is not installed. Skipping package install."; \
	fi

# Bootstrap the machine by installing dotfiles. Use brew only if desired.
bootstrap: setup
