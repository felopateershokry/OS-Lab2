#!/bin/bash

if [ $# -ne 3 ]; then
    echo "invalid input"
    exit 1
fi

dir=$1
malicious_dir=$2
interval=$3
whitelist="$(dirname "$0")/whitelist.txt"

if [ ! -d "$dir" ]; then
    echo "invalid directory"
    exit 1
fi

if [ ! -d "$malicious_dir" ]; then
    mkdir "$malicious_dir"
fi

if [ ! -f directory-info.last ]; then
    for file in "$dir"/*
        do
            filename=$(basename "$file")
            if grep -Fxq "$filename" "$whitelist"; then
                continue
            fi
            case "$file" in
                *.exe | *.bat | *.vbs | *.scr | *.ps1)
                    echo "$file is malicious and it is DELETED"
                    cp "$file" "$malicious_dir/"
                    rm "$file"
                    ;;
                *)
                    if grep -qiE 'virus|trojan|malware|worm|ransomware' "$file"; then
                        echo "$file is malicious and it is DELETED"
                        cp "$file" "$malicious_dir/"
                        rm "$file"
                    fi
                    ;;
            esac
        done
    ls -l "$dir" > directory-info.last
fi

while true
do
    sleep "$interval"

    ls -l "$dir" > directory-info.new

    if ! diff -q directory-info.last directory-info.new > /dev/null; then
        for file in "$dir"/*
        do
            filename=$(basename "$file")
            if grep -Fxq "$filename" "$whitelist"; then
                continue
            fi
            case "$file" in
                *.exe | *.bat | *.vbs | *.scr | *.ps1)
                    echo "$file is malicious and it is DELETED"
                    cp "$file" "$malicious_dir/"
                    rm "$file"
                    ;;
                *)
                    if grep -qiE 'virus|trojan|malware|worm|ransomware' "$file"; then
                        echo "$file is malicious and it is DELETED"
                        cp "$file" "$malicious_dir/"
                        rm "$file"
                    fi
                    ;;
            esac
        done
        ls -l "$dir" > directory-info.last
    else
        mv directory-info.new directory-info.last
    fi

done