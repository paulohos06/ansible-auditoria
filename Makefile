.SILENT: config lint report

auditd_report:
	ansible-playbook src/playbook.yml --tags auditd_report

auditd_scan:
	ansible-playbook src/playbook.yml --tags auditd_scan

config:
	ansible-playbook src/playbook.yml --tags config

integration_scan:
	ansible-playbook src/playbook.yml --tags lynis_integration

full_scan:
	ansible-playbook src/playbook.yml --tags lynis_full

lint:
	ansible-lint src/playbook.yml

lynis_scan:
	ansible-playbook src/playbook.yml --tags lynis_scan

pentest_scan:
	ansible-playbook src/playbook.yml --tags lynis_pentest

lynis_report:
	ansible-playbook src/playbook.yml --tags lynis_report

lynis_report_html:
	bash src/scripts/lynis_report_format.sh html

lynis_report_pdf:
	bash src/scripts/lynis_report_format.sh pdf
