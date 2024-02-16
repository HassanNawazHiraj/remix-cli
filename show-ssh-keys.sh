echo -e "Following are ssh keys added to authorized_keys:\n"

# Print the SSH keys added to authorized_keys
awk '{print $NF}' ~/.ssh/authorized_keys