#!/bin/bash
# make function usage
usage() {
    echo "Usage: $0 <input_dir> <target>"
    echo "  <input_dir> is the directory containing the files to be processed"
    echo "  <target> is the target file name to be processed"
    echo "  <target> can be either corrected or reoriented"
    echo "  <target> is corrected by default"
    exit 1
}
# Get the input directory from command-line argument
input_dir="$1"
target="$2"
# assert the input directory is provided
if [ -z "$input_dir" ]; then
    usage
fi

# assert the target variable is either corrected or reoriented
if [[ "$target" == "corrected" || "$target" == "reoriented" ]]; then
    echo "Variable is valid."
else
    usage
fi

# if target is corrected the use _corrected.nii.gz, otherwise use _reoriented.nii.gz
if [ "$target" = "corrected" ]; then
    target="_corrected.nii.gz"
else
    target="_reoriented.nii.gz"
fi

# Check if the input directory is provided
if [ -z "$input_dir" ]; then
	  echo "Please provide the input directory."
	    exit 1
fi

# Loop through all files with "_corrected.nii.gz" ending recursively
find "$input_dir" -type f -name "$target" | while read -r file; do
  # Get the file name without the extension
    echo "procesing file ${file}"
    dir_path=$(dirname "$file")
    filename=$(basename "$file" "$target")
    bet $file "${dir_path}/${filename}_brain.nii.gz"
done

