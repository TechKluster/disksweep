#!/bin/bash

# Find large files utility (Bash version)
set -eo pipefail

# Default values
DIR="${HOME}"
MIN_SIZE_MB=100
MAX_RESULTS=50

# Human readable format function
hr_size() {
    local bytes=$1
    if (( bytes >= 1000000000 )); then
        printf "%0.1f GB" "$(echo "scale=2; $bytes/1024/1024/1024" | bc)"
    else
        printf "%0.1f MB" "$(echo "scale=2; $bytes/1024/1024" | bc)"
    fi
}

# Argument parser
while getopts ":d:s:m:i" opt; do
  case $opt in
    d) DIR="$OPTARG" ;;
    s) MIN_SIZE_MB="$OPTARG" ;;
    m) MAX_RESULTS="$OPTARG" ;;
    i) INTERACTIVE=1 ;;
    \?) echo "Invalid option: -$OPTARG" >&2; exit 1 ;;
  esac
done

# Interactive mode
if [[ -n "$INTERACTIVE" ]]; then
  read -rp "Enter directory to scan [${HOME}]: " input_dir
  DIR="${input_dir:-$DIR}"
  read -rp "Minimum file size in MB [100]: " input_size
  MIN_SIZE_MB="${input_size:-$MIN_SIZE_MB}"
fi

# Validate inputs
[[ -d "$DIR" ]] || { echo "Directory not found: $DIR"; exit 1; }
[[ "$MIN_SIZE_MB" =~ ^[0-9]+$ ]] || { echo "Invalid size: $MIN_SIZE_MB"; exit 1; }

MIN_SIZE_BYTES=$((MIN_SIZE_MB * 1024 * 1024))

echo -e "\n🔍 Scanning $DIR for files > ${MIN_SIZE_MB}MB..."

# Find and process files
find "${DIR}" -type f -size +"${MIN_SIZE_MB}"M \
  -exec du -h {} + 2>/dev/null |          # Get sizes with human-readable format
  sort -hr |                              # Sort by size descending
  head -n "${MAX_RESULTS}" |              # Limit results
  while read -r size path; do
    printf "%10s | %s\n" "$size" "$path"
  done

echo -e "\n🏆 Top ${MAX_RESULTS} Largest Files Found"
