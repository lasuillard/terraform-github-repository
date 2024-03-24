#!/usr/bin/env -S make -f

MAKEFLAGS += --warn-undefined-variable
MAKEFLAGS += --no-builtin-rules
MAKEFLAGS += --silent

SHELL := bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
.DELETE_ON_ERROR:
.DEFAULT_GOAL := help

help: Makefile  ## Show help
	@grep -E '(^[a-zA-Z_-]+:.*?##.*$$)|(^##)' "$(MAKEFILE_LIST)" | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'

install:  ## Install deps

.PHONY: install

init:  ## Initialize repository
	pre-commit autoupdate
	pre-commit install --install-hooks
.PHONY: init


# =============================================================================
# CI
# =============================================================================
ci: format lint docs  ## Run CI tasks
.PHONY: ci

format:  ## Format code
	pre-commit run -a terraform_fmt
.PHONY: format

lint:  ## Lint code
	pre-commit run -a terraform_validate
	pre-commit run -a terraform_providers_lock
.PHONY: lint

docs:  ## Generate docs
	pre-commit run -a terraform_docs
.PHONY: docs
