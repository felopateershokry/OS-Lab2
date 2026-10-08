setup:
	mkdir -p malicious_dir

antivirus:
	bash antivirusd.sh dir malicious_dir 2

restore:
	bash restore.sh dir malicious_dir

