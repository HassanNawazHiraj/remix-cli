# Linux Server Setup Script

## Setup Script

This bash script automates the initial setup of a Linux system, focusing on user management, firewall configuration, and optional SSH key addition. It is designed to simplify the setup process for new systems or users.

### Usage

1. **Clone the repository or download the script directly:**

   ```bash
   git clone https://github.com/HassanNawazHiraj/server-setup-automation.git
   ```

2. **Navigate to the script directory:**

   ```bash
   cd server-setup-automation
   ```

3. **Make the script executable:**

   ```bash
   chmod +x setup.sh
   ```

4. **Run the script:**

   ```bash
   ./setup.sh
   ```

### Script Overview

1. **Update and Upgrade:**

   - Updates the package list and upgrades existing packages.

2. **Create User:**

   - Prompts the user for a username (default is 'ubuntu').
   - Checks if the user already exists.
   - Adds the user and assigns them to the sudo group if not already present.

3. **Firewall Configuration:**

   - Installs and configures Uncomplicated Firewall (ufw).
   - Allows OpenSSH connections.

4. **Add SSH Key (Optional):**
   - Asks the user if they want to add a public SSH key.
   - If yes, allows the user to paste an SSH key and confirms its addition to the authorized_keys file.
   - Supports adding multiple SSH keys in one session.

### Notes

- It's recommended to review and customize the script according to your specific needs before running it.
- Ensure that the script has execution permissions before running it.

  ```bash
  chmod +x setup.sh
  ```
