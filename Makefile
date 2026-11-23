
.PHONY: lint-workflows Lint-helm

lint-workflows:
	@echo "Checking YAML syntax..."
	yamllint -d relaxed .gitea/workflows/

	@echo "Checking workflow syntax..."
	actionlint .gitea/workflows/*.yml

	@echo "Workflow linting completed!"

Lint-helm:
	@echo "Linting Helm charts..."
	helm lint helm/kubernetes-app-nginx

	@echo "Helm linting completed!"