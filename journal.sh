#!/bin/bash

# --- Configuration ---
# Set the directory where your journals will be saved
JOURNAL_DIR="$HOME/MyJournals"

# Set your preferred editor
# Use 'vim' or 'nano'
EDITOR_CMD="vim"

# --- Setup ---
# Create the journal directory if it doesn't exist
mkdir -p "$JOURNAL_DIR"

# --- File Naming ---
# 1. Get the current timestamp for file naming (YYYY-MM-DD_HH:MM:SS)
TIMESTAMP=$(date +"%Y-%m-%d_%H:%M:%S")

# 2. Ask the user for a descriptive name/title
read -r -p "Enter a brief title for this entry (e.g., 'Morning_Thoughts'): " USER_TITLE

# Sanitize the title for use in a filename (replace spaces with underscores)
SANITIZED_TITLE=$(echo "$USER_TITLE" | tr ' ' '_')

# 3. Construct the final filename
FILENAME="${TIMESTAMP}_${SANITIZED_TITLE}.txt"
FILEPATH="$JOURNAL_DIR/$FILENAME"

# --- Journal Entry Creation ---
# 1. Create a temporary file to hold the entry content before adding the final timestamp
TEMP_FILE=$(mktemp)

echo "Starting new journal entry: $FILENAME"
echo "File will be saved in: $JOURNAL_DIR"

# 2. Launch the user's preferred editor on the temporary file
# The script execution pauses here until the user saves and exits the editor.
$EDITOR_CMD "$TEMP_FILE"

# 3. Automatic Timestamping (Adding the timestamp to the end of the text)
# Get the current date and time in a human-readable format for the entry body
ENTRY_TIMESTAMP="--- Entry recorded on: $(date +"%Y-%m-%d at %H:%M:%S") ---"

# Append the timestamp to the content of the temporary file
echo -e "\n\n$ENTRY_TIMESTAMP" >> "$TEMP_FILE"

# --- Final Save ---
# Move the finalized entry from the temporary file to the final destination
mv "$TEMP_FILE" "$FILEPATH"

echo "Journal entry saved successfully as: $FILENAME"

# Optional: Display the last few lines of the saved file to confirm
# tail -n 3 "$FILEPATH"
