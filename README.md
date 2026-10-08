# Overview
this project is a simple antivirus daemon written using Bash shell scripts
the antivirus daemon monitors a directory periodically and checks whether its contents have changed and When a change is detected it scans the files for malicious extensions or malicious keywords
malicious files are copied to a quarantine directory and then deleted from the monitored directory
the project also includes a restore tool that allows the user to restore a quarantined file or permanently delete it or leave it in quarantine
# Folder Hierarchy
lab2:
    antivirusd.sh
    restore.sh
    Makefile
    README.md
    antivirus-cron.sh
    dir/
# Prerequisites
the project requires ubuntu linux and bash and make sure the shell scripts have execute permission before running them
# Step-by-Step Instructions
# antivirus #
1: open the terminal and navigate to the project directory
2: create the "malicious_dir" directory:
        make setup
3: run the antivirus daemon:
        make antivirus
4: the antivirus daemon monitors the "dir" directory and checks for changes every 2 seconds
5: if a malicious file is detected it is copied to the "malicious_dir" directory and deleted from "dir"
6: to stop the antivirus daemon press Ctrl+C
# restore #
1: make sure the antivirus daemon is stopped
2: run the restore tool:
        make restore
3: the restore tool displays the files currently in the "malicious_dir" directory
4; select a file by entering its number
5: choose one of the following options:
        restore the file back to "dir"
        permanently delete the file from "malicious_dir"
        leave the file in "malicious_dir" and return to the list