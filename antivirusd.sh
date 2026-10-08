#!/bin/bash

if [ $# -ne 3 ]; then
    echo "invalid input"
    exit 1
fi

dir=$1
malicious_dir=$2
interval=$3

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
            case "$file" in
                *.exe | *.bat | *.vbs | *.src | *.ps1)
                    echo "$file is malicious and it is deleted"
                    cp "$file" "$malicious_dir/"
                    rm "$file"
                    ;;
                *)
                    if grep -qiE 'virus|trojan|malware|worm|ransomware' "$file"; then
                        echo "$file is malicious and it is deleted"
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
            case "$file" in
                *.exe | *.bat | *.vbs | *.src | *.ps1)
                    echo "$file is malicious and it is deleted"
                    cp "$file" "$malicious_dir/"
                    rm "$file"
                    ;;
                *)
                    if grep -qiE 'virus|trojan|malware|worm|ransomware' "$file"; then
                        echo "$file is malicious and it is deleted"
                        cp "$file" "$malicious_dir/"
                        rm "$file"
                    fi
                    ;;
            esac
        done
    fi

    mv directory-info.new directory-info.last
done