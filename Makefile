
# Makefile
# usage make <target>

.PHONY: lint-workflows Lint-helm help
.DEFAULT_GOAL := help

help:
	@echo "Available targets:"
	@echo "  lint-workflows - Check YAML and workflow syntax"
	@echo "  Lint-helm - Lint Helm charts"

lint-workflows:
	@echo "Checking YAML syntax..."
	yamllint -d relaxed .gitea/workflows/

	@echo "Checking workflow syntax..."
	actionlint .gitea/workflows/*.yml

	@echo "Workflow linting completed!"

lint-helm:
	@echo "Linting Helm charts..."
	helm lint helm/kubernetes-app-nginx

	@echo "Helm linting completed!"