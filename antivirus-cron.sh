#!/bin/bash

dir="dir"
malicious_dir="malicious_dir"

if [ ! -d "$malicious_dir" ]; then
    mkdir "$malicious_dir"
fi

extensions=("exe" "bat" "vbs" "scr" "ps1")
keywords=("virus" "trojan" "malware" "worm" "ransomware")

for file in "$dir"/*; 
do
    [ -f "$file" ] || continue

    filename=$(basename "$file")
    malicious=false

    for ext in "${extensions[@]}"; do
        if [[ "$filename" == *."$ext" ]]; then
            malicious=true
            break
        fi
    done

    if [ "$malicious" = false ]; then
        for keyword in "${keywords[@]}"; do
            if grep -qi "$keyword" "$file"; then
                malicious=true
                break
            fi
        done
    fi

    if [ "$malicious" = true ]; then
        echo "$file is malicious and it is DELETED"
        cp "$file" "$malicious_dir/$filename"
        rm "$file"
    fi

done