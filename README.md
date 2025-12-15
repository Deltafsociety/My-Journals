# Terminal Journal App

A simple, personalized command-line application for quick journaling. Write your entries using your favorite terminal editor (Vim/Nano), and the app automatically handles file naming, custom headers, and timestamping.

## Features

* **Vim/Nano Integration:** Write comfortably in your preferred terminal editor.
* **Automatic Naming:** Files are named using a precise timestamp and your chosen title: `YYYY-MM-DD_HH:MM:SS_Your_Title.txt`.
* **Custom Template Support:** Automatically insert a decorative header and structured metadata (`template.txt`).
* **Automatic Timestamping:** A final, machine-readable timestamp is appended to the bottom of the entry after you save and exit the editor.

## Installation & Setup

1.  **Clone the Repository:**
    ```bash
    git clone [YOUR_REPO_URL]
    cd [YOUR_REPO_NAME]
    ```

2.  **Make the Script Executable:**
    ```bash
    chmod +x journal.sh
    ```

3.  **Define Journal Directory:**
    The script will create a journal directory at `$HOME/MyJournals`. You can change this path within the `journal.sh` file if necessary.

4.  **Customize Your Header (Optional):**
    The app uses the included `template.txt` for the entry structure. Edit this file to customize your ASCII art or starting prompts.

## Usage

Run the script from your terminal:

```bash
./journal.sh
