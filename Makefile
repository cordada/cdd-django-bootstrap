SHELL = /usr/bin/env bash -e -o pipefail

PYTHON = python3
NODEJS_NPM = npm

.DEFAULT_GOAL := help

.PHONY: help
help:
	@echo "$@: Read README.md"

.PHONY: clean
clean: ## Delete temporary files, logs, cached files, build artifacts, etc.
	find . -iname __pycache__ -type d -prune -exec rm -r {} \;
	find . -iname '*.py[cod]' -delete

	$(RM) -r build
	$(RM) -r dist
	find . -iname '*.egg-info' -type d -prune -exec $(RM) -r {} \;

	find . -iname node_modules -type d -prune -exec $(RM) -r {} \;

.PHONY: build
build: ## Build Python package
build: build-scss
	$(PYTHON) setup.py build

.PHONY: build-scss
build-scss: ## Build CSS from SCSS using Sass
	$(NODEJS_NPM) install
	$(NODEJS_NPM) run-script build

.PHONY: dist
dist: build
dist: ## Create Python package distribution
	$(PYTHON) setup.py sdist
	$(PYTHON) setup.py bdist_wheel

.PHONY: lint
lint: ## Run linters
	$(PYTHON) setup.py check --metadata
