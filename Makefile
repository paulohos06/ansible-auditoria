.SILENT: config lint report

config:
	ansible-playbook src/playbook.yml --tags config

devops_scan:
	ansible-playbook src/playbook.yml --tags auditd_scan, lynis_devops

full_scan:
	ansible-playbook src/playbook.yml --tags auditd_scan, lynis_full

lint:
	ansible-lint src/playbook.yml

pentest_scan:
	ansible-playbook src/playbook.yml --tags auditd_scan, lynis_pentest

report:
	ansible-playbook src/playbook.yml --tags report
	bash src/scripts/generate_html_pdf_reports.sh
