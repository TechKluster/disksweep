#!/usr/bin/env python3
import os
import argparse
from humanize import naturalsize

def find_large_files(directory, min_size_mb, max_results=50):
    min_size_bytes = min_size_mb * 1024 * 1024
    large_files = []

    print(f"\n🔍 Scanning {directory} for files > {min_size_mb}MB...")

    for root, dirs, files in os.walk(directory):
        for file in files:
            path = os.path.join(root, file)
            try:
                size = os.path.getsize(path)
                if size > min_size_bytes:
                    large_files.append((path, size))
            except (PermissionError, FileNotFoundError):
                continue

    # Sort by size descending
    large_files.sort(key=lambda x: x[1], reverse=True)

    # Print results
    print(f"\n🏆 Top {max_results} Largest Files Found:")
    for path, size in large_files[:max_results]:
        print(f"{naturalsize(size):>10} | {path}")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Find large files on your Mac')
    parser.add_argument('-d', '--directory', default=os.path.expanduser('~'),
                       help='Directory to search (default: home directory)')
    parser.add_argument('-s', '--size', type=int, default=100,
                       help='Minimum file size in MB (default: 100)')
    parser.add_argument('-i', '--interactive', action='store_true',
                       help='Run in interactive mode')

    args = parser.parse_args()

    if args.interactive:
        directory = input("Enter directory to scan [~/]: ") or os.path.expanduser('~')
        min_size = int(input("Minimum file size in MB [100]: ") or 100)
        find_large_files(directory, min_size)
    else:
        find_large_files(args.directory, args.size)
