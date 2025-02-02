#!/bin/bash
read -p "Enter source directory: " src
read -p "Enter destination directory: " dest
tar -czvf "$dest/backup.tar.gz" "$src"
echo "Backup completed!"
