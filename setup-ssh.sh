DIR="$(dirname "$0")"

# Install ufw if not already installed
sudo apt install ufw -y

# Allow OpenSSH
sudo ufw allow OpenSSH

# Enable ufw
sudo ufw enable

# Ask user if they want to add a public SSH key
${DIR}/add-ssh-key.sh