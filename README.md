# Gotenberg Converter

![Bash](https://img.shields.io/badge/Script-Bash-4EAA25?logo=gnu-bash&logoColor=white)
![Batch](https://img.shields.io/badge/Script-Batch-0078D6?logo=windows&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green)

# Highlights

- **Gotenberg Scripts:** Command-line scripts featuring both `.bat` and `.sh` versions, providing cross-platform compatibility depending on the operating system you are running.

# Overview

Gotenberg Converter is a lightweight, interactive command-line utility designed to mass-convert documents (such as `.odt`, `.docx`, etc.) into PDFs using a self-hosted Gotenberg API. 

Instead of converting files one by one or relying on complex configurations, this tool prompts the user for the necessary parameters (Gotenberg server IP, source folder, target file extension, and destination folder) and automatically loops through the directory to batch-convert the files. It acts as a bridge between your local file system and your Gotenberg instance.

# Author

I'm Jonathan, and I develop projects in my spare time that help myself and others become better and more efficient developers!
- [LinkedIn](https://www.linkedin.com/in/jonathan-windell-418a55232/)
- [Portfolio](https://portfolio.jonathans-labb.org/)

# Usage Instructions

### Prerequisites
- A running instance of **Gotenberg** (accessible via an IP address and port).
- `curl` installed on your machine (usually pre-installed on modern Windows, macOS, and Linux systems).

### For Windows (.bat)
1. Download or clone this repository to your local machine.
2. Locate the `.bat` file (e.g., `mass-convert.bat`).
3. Double-click the file to run it.
4. A command prompt window will open. Follow the interactive steps to provide your Gotenberg IP, source folder, file extension, and target folder.

### For Linux/Unix (.sh)
1. Download or clone this repository to your local machine.
2. Open your terminal and navigate to the directory where the script is located.
3. Make the script executable by running:
   ```bash
   chmod +x mass-convert.sh
   ```
4: Execute the script:
    ```bash
    ./mass-convert.sh
    ```

5: Follow the interactive prompts in your terminal to complete the batch conversion.

# Contributions

Contributions are welcome! Please ensure you include tests for any new features.
1. **Fork** the project.
2. Create your Feature Branch (git checkout -b feature/UserFeature).
3. Commit your changes (git commit -m 'Add some Feature').
4. Push to the Branch (git push origin feature/UserFeature).
5. Open a **Pull Request**.

# License

Distributed under the MIT License. See `LICENSE` file for more information.