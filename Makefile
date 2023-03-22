.SILENT: config report

config:
	ansible-playbook src/playbook.yml --tags config

full_scan:
	ansible-playbook src/playbook.yml --tags auditd_scan, lynis_full

pentest_scan:
	ansible-playbook src/playbook.yml --tags auditd_scan, lynis_pentest

report:
	ansible-playbook src/playbook.yml --tags report
	bash src/scripts/generate_html_pdf_reports.sh

	
