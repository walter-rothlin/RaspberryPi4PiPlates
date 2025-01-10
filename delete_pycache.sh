#!/bin/bash

# Script to delete all __pycache__ directories recursively
# Usage: ./delete_pycache.sh [directory]

# Set the target directory or use the current directory if none is specified
TARGET_DIR=${1:-.}

echo "Searching for __pycache__ directories in $TARGET_DIR..."

# Find and delete all __pycache__ directories, while logging their paths
find "$TARGET_DIR" -type d -name "__pycache__" -print -exec rm -rf {} +

if [ $? -eq 0 ]; then
    echo "The following __pycache__ directories were deleted:"
    find "$TARGET_DIR" -type d -name "__pycache__"
    echo "Deletion process completed successfully."
else
    echo "An error occurred while deleting __pycache__ directories."
fi

