
# Makefile
# usage make <target>

.PHONY: lint-workflows lint-helm help
.DEFAULT_GOAL := help

HELM_CHART_PATH := ./helm-chart/kubernetes-app-nginx

help:
	@echo "Available targets:"
	@echo "  lint-workflows - Check YAML and workflow syntax"
	@echo "  lint-helm - Lint Helm charts"

lint-workflows:
	@echo "Checking YAML syntax..."
	yamllint -d relaxed .gitea/workflows/

	@echo "Checking workflow syntax..."
	actionlint .gitea/workflows/*.yml

	@echo "Workflow linting completed!"

lint-helm:
	@echo "Linting Helm charts..."
	helm lint $(HELM_CHART_PATH)

	@echo "Linting yaml"
	yamllint -d relaxed $(HELM_CHART_PATH)


	@echo "Helm linting completed!"