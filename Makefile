
# Makefile
# usage make <target>

.PHONY: lint-yaml lint-action lint-helm help
.DEFAULT_GOAL := help

HELM_CHART_PATH := ./helm-chart/kubernetes-app-nginx

help:
	@echo "Available targets:"
	@echo "  lint-yaml - Check YAML syntax"
	@echo "  lint-helm - Lint Helm charts"

lint-yaml:
	@echo "Checking YAML syntax..."
	yamllint -s .

	@echo "Workflow linting completed!"

lint-action:
	@echo "Checking workflow syntax..."
	actionlint .gitea/workflows/*.yml

	@echo "Workflow linting completed!"

lint-helm:
	@echo "Linting Helm charts..."
	helm lint $(HELM_CHART_PATH)

	@echo "Helm linting completed!"