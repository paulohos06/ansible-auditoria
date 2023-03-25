.SILENT: config lint report

default: help

.PHONY: scan
auditd/scan: # Scan audit logs and generate a summary.
	ansible-playbook src/playbook.yml --tags auditd_scan

.PHONY: auditd
auditd/report: # Get auditd reports from nodes.
	ansible-playbook src/playbook.yml --tags auditd_report

.PHONY: config
config: # Config auditd and lynis on your system.
	ansible-playbook src/playbook.yml --tags config

lynis/scan/full:
	ansible-playbook src/playbook.yml --tags lynis_full

lynis/scan/integration:
	ansible-playbook src/playbook.yml --tags lynis_integration

lynis/scan/pentest:
	ansible-playbook src/playbook.yml --tags lynis_pentest

.PHONY: help
help: # Show help for each of the Makefile recipes.
	@grep -E '^[a-zA-Z0-9 -]+:.*#'  Makefile | sort | while read -r l; do printf "\033[1;32m$$(echo $$l | cut -f 1 -d':')\033[00m:$$(echo $$l | cut -f 2- -d'#')\n"; done

.PHONY: lint
lint: # Lint ansible artefacts.
	ansible-lint src/playbook.yml

.PHONY: lynis_scan
lynis/scan: # Scan and generate different types of reports.
	ansible-playbook src/playbook.yml --tags lynis_scan

lynis/report:
	ansible-playbook src/playbook.yml --tags lynis_report

lynis/report/html:
	bash src/scripts/lynis_report_format.sh html

lynis/report/pdf:
	bash src/scripts/lynis_report_format.sh pdf
