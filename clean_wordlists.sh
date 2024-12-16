#!/bin/bash



# Check if the correct number of arguments is passed
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <input_wordlist> <output_wordlist>"
    exit 1
fi

INPUT_FILE="$1"
OUTPUT_FILE="$2"

# Check if the input file exists
if [ ! -f "$INPUT_FILE" ]; then
    echo "Error: Input file '$INPUT_FILE' not found!"
    exit 1
fi

# Clean the wordlist
# 1. Remove non-printable characters
# 2. Remove duplicates
# 3. Remove words shorter than 4 or longer than 32 characters
# 4. Sort the wordlist alphabetically

cat "$INPUT_FILE" \
    | tr -cd '\11\12\15\40-\176' \  # Remove non-printable characters
    | awk '{ if(length($0) >= 4 && length($0) <= 32) print $0 }' \  # Filter by length
    | sort -u \  # Remove duplicates and sort
    > "$OUTPUT_FILE"

echo "Wordlist cleaned and saved to '$OUTPUT_FILE'."
