#!/bin/bash
read -p "Enter directory path: " dir
if [ -d "$dir" ]; then
    du -sh "$dir"
else
    echo "Directory does not exist"
fi
