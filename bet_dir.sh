#!/bin/bash

# Get the input directory from command-line argument
input_dir="$1"

# Check if the input directory is provided
if [ -z "$input_dir" ]; then
	  echo "Please provide the input directory."
	    exit 1
fi

# Loop through all files with "_corrected.nii.gz" ending recursively
find "$input_dir" -type f -name "*_corrected.nii.gz" | while read -r file; do
  # Get the file name without the extension
    echo "procesing file ${file}"
    dir_path=$(dirname "$file")
    filename=$(basename "$file" _corrected.nii.gz)
    bet $file "${dir_path}/${filename}_brain.nii.gz"
done

