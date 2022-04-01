ANSIBLE_OPT=--diff --vault-password-file=~/bin/op-vault
LIMIT ?= all

.PHONY: help
help: ## Display help message (*: main entry points / []: part of an entry point)
	@grep -E '^[0-9a-zA-Z_-]+\.*[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: check-connectivity
check-connectivity:  ## Test connectivity with lab devices
	ansible-playbook playbooks/check-device-connectivity.yml $(ANSIBLE_OPT) --limit $(LIMIT)

.PHONY: build
build:  ## Build devices configuration for Fabric and firewall.
	ansible-playbook playbooks/avd-build-and-deploy.yml $(ANSIBLE_OPT) --tags build --skip-tags debug --limit $(LIMIT)
	ansible-playbook playbooks/panos-config-deploy.yml $(ANSIBLE_OPT) --tags build --skip-tags debug --limit $(LIMIT)


.PHONY: deploy
deploy:  ## Run only deployment phase (BUILD is a requirement)
	ansible-playbook playbooks/avd-build-and-deploy.yml $(ANSIBLE_OPT) --tags deploy --skip-tags debug --limit $(LIMIT)
	ansible-playbook playbooks/panos-config-deploy.yml $(ANSIBLE_OPT) --tags deploy,policy --skip-tags debug --limit $(LIMIT)


.PHONY: apply-all
apply-all:  ## Build and deploy services on both fabric and firewall
	ansible-playbook playbooks/avd-build-and-deploy.yml $(ANSIBLE_OPT) --tags build,deploy --skip-tags debug --limit $(LIMIT)
	ansible-playbook playbooks/panos-config-deploy.yml $(ANSIBLE_OPT) --tags build,deploy,policy --skip-tags debug --limit $(LIMIT)


.PHONY: clean-firewall
clean-firewall:  ## Restaure firewall in its initial state (no interface, no security object, no policy)
	ansible-playbook playbooks/panos-config-remove.yml $(ANSIBLE_OPT)


.PHONY: clean-fabric
clean-fabric:  ## Restore Fabric to a state with no service configured
	mv dc1-inventory/group_vars/fabric_services/services.yml dc1-inventory/group_vars/fabric_services/services.yml.old
	mv dc1-inventory/group_vars/fabric_ports/firewalls.yml dc1-inventory/group_vars/fabric_ports/firewalls.yml.old
	mv dc1-inventory/group_vars/fabric_ports/servers.yml dc1-inventory/group_vars/fabric_ports/servers.yml.old
	ansible-playbook playbooks/avd-build-and-deploy.yml $(ANSIBLE_OPT) --tags build --skip-tags debug --limit eos
	mv dc1-inventory/group_vars/fabric_services/services.yml.old dc1-inventory/group_vars/fabric_services/services.yml
	mv dc1-inventory/group_vars/fabric_ports/firewalls.yml.old dc1-inventory/group_vars/fabric_ports/firewalls.yml
	mv dc1-inventory/group_vars/fabric_ports/servers.yml.old dc1-inventory/group_vars/fabric_ports/servers.yml
	ansible-playbook playbooks/avd-build-and-deploy.yml $(ANSIBLE_OPT) --tags deploy --skip-tags debug --limit $(LIMIT)
