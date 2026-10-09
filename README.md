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
    malicious_dir/
    whitelist.txt
# Prerequisites
the project requires ubuntu linux and bash and make sure the shell scripts have execute permission before running them
# Step-by-Step Instructions
the provided Makefile runs the antivirus daemon using `dir` as the monitored directory and `malicious_dir` as the quarantine directory
# antivirus #
1: open the terminal and navigate to the project directory
2: create the `malicious_dir` directory:
        make setup
3: run the antivirus daemon:
        make antivirus
4: the antivirus daemon monitors the `dir` directory and checks for changes every 2 seconds
5: if a malicious file is detected it is copied to the `malicious_dir` directory and deleted from `dir`
6: to stop the antivirus daemon press Ctrl+C
# restore #
1: make sure the antivirus daemon is stopped
2: run the restore tool:
        make restore
3: the restore tool displays the files currently in the `malicious_dir` directory
4: select a file by entering its number
5: choose one of the following options:
        restore the file back to `dir`
        permanently delete the file from `malicious_dir`
        leave the file in `malicious_dir` and return to the list
# Malicious Extensions and Keywords

the malicious file detection rules are defined inside `antivirusd.sh`

the flagged extensions are: `.exe`, `.bat`, `.vbs`, `.scr`, and `.ps1`

only the final file extension is checked

the flagged keywords are: `virus`, `trojan`, `malware`, `worm`, and `ransomware`

keyword matching is case insensitive and matches substrings anywhere in the file contents
# Bonus 1 - Cron
# Cron Setup

1: open the crontab editor:
        crontab -e

2: add the following cron job:
        * * * * * cd /home/felopateershokry/Documents/lab2 && sleep 23 && bash antivirus-cron.sh
        ctrl O
        Enter
        ctrl X

3: this runs the antivirus cron script every minute at second 23

4: the script scans the `dir` directory and moves malicious files to `malicious_dir`
# Cron Expression for Every 3rd Friday

31 0 15-21 * 5

this runs at 12:31 AM on Fridays that fall between the 15th and 21st day of the month, which represents the third Friday of the month

# Bonus 2 - Whitelist
the whitelist stores the names of files that were identified as false positives and restored by the user
files listed in the whitelist are ignored by the antivirus scripts even if their contents contain malicious keywords or their extensions are flagged
# How It Works
1: when the user restores a file using `restore.sh` its filename is added to `whitelist.txt`
2: the `antivirusd.sh` daemon checks the whitelist before scanning each file
3: the `antivirus-cron.sh` script also checks the whitelist before scanning each file
4: whitelisted files are skipped and are not moved to `malicious_dir`
5: the whitelist is stored in `whitelist.txt` so its entries remain available after the scripts stop or restart
6: The whitelist is based on filenames therefore another file with the same filename will also be skipped by the antivirus scripts
# Testing
1: restore a quarantined file using `restore.sh`
2: verify that its filename has been added to `whitelist.txt`
3: place a file with the same name in `dir` and include a malicious keyword such as `virus` in its contents
4: run `antivirusd.sh` and verify that the file remains in `dir`
5: run `antivirus-cron.sh` and verify that the file also remains in `dir`
6: test a file that is not whitelisted and contains a malicious keyword verify that it is moved to `malicious_dir`