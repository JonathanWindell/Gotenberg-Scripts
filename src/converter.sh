#!/bin/bash
echo "====================================================="
echo "   GOTENBERG MASS-Converter"
echo "====================================================="
echo ""

# Asks user for IP address & port to Gotenberg
read -p "Enter your IP address and port to Gotenberg (Example: 192.168.X.X:3000): " USER_URL

# 1: Configuration
# Note: Gotenberg v8 requires '/forms/' before '/libreoffice/convert'
GOTENBERG_URL="http://${USER_URL}/forms/libreoffice/convert"

# 2: Interactive Input
read -p "Folder with original files (Example: ./My-Documents): " SOURCE_DIR
if [ ! -d "$SOURCE_DIR" ]; then
    echo "[ERROR] Folder \"$SOURCE_DIR\" was not found."
    # Simulate 'pause' in Linux
    read -p "Press [Enter] to exit..."
    exit 1
fi

read -p "Which file type should be converted? (Example: odt, docx): " FILE_EXT
# Delete . if user enters by mistake .odt
FILE_EXT="${FILE_EXT#.}"

read -p "Folder for finished PDF:s (Example: ./Converted-PDFs): " TARGET_DIR
# If target folder does not exist. Create
if [ ! -d "$TARGET_DIR" ]; then
    echo "Creating target folder..."
    mkdir -p "$TARGET_DIR"
fi

echo ""
echo "Executing converting!"
echo "-----------------------------------------------------"

COUNT=0
SUCCESS=0

# Enable nullglob so the loop doesn't run if no files are found
shopt -s nullglob

# Conversion Loop
for FILE in "$SOURCE_DIR"/*."$FILE_EXT"; do
    ((COUNT++))
    
    # Extract just the filename with and without extension
    BASENAME=$(basename "$FILE")
    FILENAME="${BASENAME%.*}"
    
    echo "Sending $BASENAME to Gotenberg"
    
    # Sending files using curl
    curl -s -o "$TARGET_DIR/$FILENAME.pdf" --request POST "$GOTENBERG_URL" --form "files=@\"$FILE\""
    
    # Control if file was created
    if [ -f "$TARGET_DIR/$FILENAME.pdf" ]; then
        ((SUCCESS++))
        echo " -> [ Finished ]"
    else
        echo " -> [ Error ]"
    fi
done

echo "-----------------------------------------------------"
if [ "$COUNT" -eq 0 ]; then
    echo "Found no files of type $FILE_EXT in $SOURCE_DIR."
else
    echo "Finished! Converted $SUCCESS of $COUNT files."
    echo "Your converted PDF:s wait in: $TARGET_DIR"
fi
echo ""

# Optional: Simulate 'pause' at the end like in batch
read -p "Press [Enter] to exit..."