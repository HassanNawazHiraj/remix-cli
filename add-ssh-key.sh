read -p "Do you want to add a public SSH key? (y/n): " add_ssh_key

if [ "$add_ssh_key" = "y" ]; then
    add_another_key="y"
    
    while [ "$add_another_key" = "y" ]; do
        # Ask user to paste the public SSH key
        echo "Paste the public SSH key below (press ctrl + d when done):"
        ssh_key_content=$(cat)
        
        # Print the SSH key to verify
        echo -e "\nThe following SSH key will be added:"
        echo "$ssh_key_content"
        
        # Ask user to confirm or re-enter the SSH key
        read -p "Do you want to proceed with adding this SSH key? (y/n/skip): " confirm_ssh_key
        
        if [ "$confirm_ssh_key" = "y" ]; then
            # Add SSH key to authorized_keys
            mkdir -p ~/.ssh
            echo "$ssh_key_content" >> ~/.ssh/authorized_keys
            echo "SSH key added to authorized_keys successfully."
            elif [ "$confirm_ssh_key" = "n" ]; then
            # Ask user to re-enter the SSH key
            echo "Please re-enter the SSH key:"
            ssh_key_content=$(cat)
            echo -e "\nThe following SSH key will be added:"
            echo "$ssh_key_content"
            read -p "Do you want to proceed with adding this SSH key? (y/n/skip): " confirm_ssh_key
            
            if [ "$confirm_ssh_key" = "y" ]; then
                # Add SSH key to authorized_keys
                echo "$ssh_key_content" >> ~/.ssh/authorized_keys
                echo "SSH key added to authorized_keys successfully."
            else
                echo "Skipping adding SSH key."
            fi
        else
            echo "Skipping adding SSH key."
        fi
        
        # Ask user if they want to add another key
        read -p "Do you want to add another SSH key? (y/n): " add_another_key
    done
fi