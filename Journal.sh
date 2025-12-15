#!/bin/bash

# =========================================================
# CONFIGURATION
# =========================================================

# Set the directory where your journals will be saved
JOURNAL_DIR="$HOME/MyJournals"

# Set your preferred editor: 'vim' or 'nano'
EDITOR_CMD="vim"

# Define the path to your ASCII art template file
TEMPLATE_FILENAME="template.txt"
TEMPLATE_PATH="$JOURNAL_DIR/$TEMPLATE_FILENAME"

# =========================================================
# SETUP AND NAMING
# =========================================================

# 1. Create the journal directory if it doesn't exist
mkdir -p "$JOURNAL_DIR"

# 2. Get the current timestamp for file naming (YYYY-MM-DD_HH:MM:SS)
TIMESTAMP=$(date +"%Y-%m-%d_%H:%M:%S")

# 3. Ask the user for a descriptive name/title
read -r -p "Enter a brief title for this entry: " USER_TITLE

# Sanitize the title for use in a filename (replace spaces with underscores)
SANITIZED_TITLE=$(echo "$USER_TITLE" | tr ' ' '_')

# 4. Construct the final filename and path
FILENAME="${TIMESTAMP}_${SANITIZED_TITLE}.txt"
FILEPATH="$JOURNAL_DIR/$FILENAME"

# =========================================================
# JOURNAL ENTRY CREATION
# =========================================================

echo "Starting new journal entry: $FILENAME"
echo "File will be saved in: $JOURNAL_DIR"

# 1. Create a temporary file to hold the entry content
TEMP_FILE=$(mktemp)

# 2. Copy the template into the temporary file if it exists
if [ -f "$TEMPLATE_PATH" ]; then
    # Copy the template content
    cat "$TEMPLATE_PATH" > "$TEMP_FILE"

    # Use sed to replace placeholders in the template with actual values
    # IMPORTANT: This requires placeholders like __DATE__ and __TITLE__ in your template.txt

    # Current formatted date and time for the template body
    CURRENT_DATE=$(date +"%A, %B %d, %Y")

    # Replace the date placeholder
    sed -i '' "s|__DATE__|$CURRENT_DATE|g" "$TEMP_FILE" 2>/dev/null || \
    sed -i "s|__DATE__|$CURRENT_DATE|g" "$TEMP_FILE"

    # Replace the title placeholder
    sed -i '' "s|__TITLE__|$USER_TITLE|g" "$TEMP_FILE" 2>/dev/null || \
    sed -i "s|__TITLE__|$USER_TITLE|g" "$TEMP_FILE"

else
    echo "Warning: Template file not found at $TEMPLATE_PATH. Starting with a blank file."
fi


# 3. Launch the user's preferred editor on the temporary file
# Script pauses here until the user saves and exits the editor.
$EDITOR_CMD "$TEMP_FILE"

# 4. Automatic Timestamping (Adding the final footer timestamp)
ENTRY_FOOTER="--- Entry recorded and finalized on: $(date +"%Y-%m-%d at %H:%M:%S") ---"
echo -e "\n\n$ENTRY_FOOTER" >> "$TEMP_FILE"

# =========================================================
# FINAL SAVE
# =========================================================

# Move the finalized entry from the temporary file to the final destination
mv "$TEMP_FILE" "$FILEPATH"

echo "✅ Journal entry saved successfully as: $FILENAME"
# Optional: Display the final journal location
echo "Location: $FILEPATH"
