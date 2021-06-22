SHELL = /usr/bin/env bash -e -o pipefail

PYTHON = python3

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
	$(RM) -r *.egg-info

.PHONY: build
build: ## Build Python package
	$(PYTHON) setup.py build

.PHONY: dist
dist: build
dist: ## Create Python package distribution
	$(PYTHON) setup.py sdist
	$(PYTHON) setup.py bdist_wheel

.PHONY: lint
lint: ## Run linters
	$(PYTHON) setup.py check --metadata
