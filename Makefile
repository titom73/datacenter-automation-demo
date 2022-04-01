ANSIBLE_OPT=--diff --vault-password-file=~/bin/op-vault
LIMIT ?= all

### Build Phase

.PHONY: check-connectivity
check-connectivity:
	ansible-playbook playbooks/check-device-connectivity.yml $(ANSIBLE_OPT) --limit $(LIMIT)

.PHONY: build
build:
	ansible-playbook playbooks/avd-build-and-deploy.yml $(ANSIBLE_OPT) --tags build --skip-tags debug --limit $(LIMIT)
	ansible-playbook playbooks/panos-config-deploy.yml $(ANSIBLE_OPT) --tags build --skip-tags debug --limit $(LIMIT)


.PHONY: deploy
deploy:
	ansible-playbook playbooks/avd-build-and-deploy.yml $(ANSIBLE_OPT) --tags deploy --skip-tags debug --limit $(LIMIT)
	ansible-playbook playbooks/panos-config-deploy.yml $(ANSIBLE_OPT) --tags deploy,policy --skip-tags debug --limit $(LIMIT)


.PHONY: apply-all
apply-all:
	ansible-playbook playbooks/avd-build-and-deploy.yml $(ANSIBLE_OPT) --tags build,deploy --skip-tags debug --limit $(LIMIT)
	ansible-playbook playbooks/panos-config-deploy.yml $(ANSIBLE_OPT) --tags build,deploy,policy --skip-tags debug --limit $(LIMIT)


.PHONY: clean-firewall
clean-firewall:
	ansible-playbook playbooks/panos-config-remove.yml $(ANSIBLE_OPT)