# Linux Server Setup Script

## Setup Script

This bash script automates the initial setup of a Ubuntu 22.04 system, focusing on LEMP stack setup with nodejs scripts coming soon.

You should be able to create static html & php website with ssl.

## Requirements

- Ubuntu 22.04
- 1gb ram (512mb fails the script)
- At least 5gb available space

## Guides
This script follows the following guides. 
https://www.digitalocean.com/community/tutorials/initial-server-setup-with-ubuntu-22-04
https://www.digitalocean.com/community/tutorials/how-to-install-linux-nginx-mysql-php-lemp-stack-on-ubuntu-22-04

Cert bot is used to generate Lets encrypt SSLs

### Usage

1. **Clone the repository or download the script directly:**

   ```bash
   git clone https://github.com/HassanNawazHiraj/server-setup-automation.git cli
   ```
   better to run this at a folder where you can go back to run individual scripts

2. **Navigate to the script directory:**

   ```bash
   cd cli
   ```

3. **Make the script executable:**

   ```bash
   chmod +x *.sh
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

5. **LEMP setup (Optional):**
   - Asks the user if they want to setup LEMP
   - installs nginx
   - asks user if they want to open http or both http+https port 
   - installs mysql
   - runs mysql security script
   - asks user which php version to install
   - asks user if they want to modify default nginx config to allow php, clear /var/www/html and add index.php which prints phpinfo
   - restarts nginx
6. **Setup finished:**
   - prints server ip 
