.ONESHELL:
.SHELL := /usr/bin/bash
.PHONY: backup clean commit ctrl-z fmt test validate

export TF_IN_AUTOMATION=1
export TF_INPUT=0

fmt:
	@terraform fmt -recursive

validate: fmt
	@terraform init -backend=false -lock=false
	@terraform validate

test: validate
	@export NAME=$${NAME:-simple}
	@terraform init
	@terraform plan -out=plan.tfplan -var-file=test-vars/$${NAME}.tfvars
	@terraform apply -refresh=false plan.tfplan
	@rm -f plan.tfplan

backup:
	@unset TS
	@export TS="$$(date +%s).backup"
	@mkdir "$$TS" || exit 1
	@cp main.tf variables.tf outputs.tf "$$TS"
	@git status --short 2> /dev/null

ctrl-z:
	@unset TS
	@export TS=$$(find . -type d -name '*.backup' | sort | tail -1)
	@test -d "$$TS" && test -f "$$TS/main.tf" && test -f "$$TS/variables.tf" && test -f "$$TS/outputs.tf" || exit 1
	@cp -f "$$TS/main.tf" main.tf
	@cp -f "$$TS/variables.tf" variables.tf
	@cp -f "$$TS/outputs.tf" outputs.tf
	@rm -rf "$$TS"
	@git status --short 2> /dev/null

clean:
	@find . -depth -type d -a '(' \
		-name '.terraform' \
		-o \
		-name '*.backup' \
	')' -exec rm -rf '{}' +
	@find . -depth -type f -a '(' \
		-name '*.log' \
		-o \
		-name '*.tfstate' \
		-o \
		-name '*.tfstate.*' \
		-o \
		-name '*.tfplan' \
		-o \
		-name '*.backup' \
	')' -exec rm -rf '{}' +

commit: validate clean
	@export COMMIT_MESSAGE="$(message)"
	@test -n "$$COMMIT_MESSAGE" || exit 1
	@git add .
	@git commit -m "$$COMMIT_MESSAGE"
