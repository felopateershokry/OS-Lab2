#!/bin/bash

if [ $# -ne 2 ]; then
    echo "invalid input"
    exit 1
fi

dir=$1
malicious_dir=$2

if [ ! -d "$dir" ]; then
    echo "invalid directory"
    exit 1
fi

if [ ! -d "$malicious_dir" ]; then
    echo "invalid malicious directory"
    exit 1
fi


while true
do
    if [ -z "$(ls -A "$malicious_dir")" ]; then
        echo "No malicious files to review."
        exit 0
    fi

    files=("$malicious_dir"/*)
    i=0
    for file in "${files[@]}"
    do
        ((i++))
        echo "$i: $file"
    done

    read -p "choose a file " choice

    if [  "$choice" -lt 1 ] || [ "$choice" -gt "${#files[@]}" ]; then
        echo "invalid choice"
        continue
    fi

    selected_file="${files[$((choice-1))]}"

    echo "1- restoring $selected_file to $dir
2- deleting $selected_file
3- leave $selected_file and go back to the list"
    read -p "choose an option " option
    if [ "$option" = "1" ]; then
        cp "$selected_file" "$dir/"
        rm "$selected_file"
        echo "Restored $selected_file to $dir"
    elif [ "$option" = "2" ]; then
        rm "$selected_file"
        echo "$selected_file permanently deleted"
    elif [ "$option" = "3" ]; then
        continue
    fi
done