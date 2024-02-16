# Function to ask user to enter PHP version to use
function select_php_version {
    echo "Following are PHP versions installed on your server:" >&2
    ls /etc/php | grep -E '^[0-9]' >&2
    echo -e "\n" >&2
    local php_version=$(ls /etc/php | grep -E '^[0-9]' | head -1)
    read -p "Enter the PHP version you want to use (leave empty to use $php_version): " php_version
    
    # If php_version is empty, set it to the first directory in /etc/php
    if [ -z "$php_version" ]; then
        php_version=$(ls /etc/php | grep -E '^[0-9]' | head -1)
    fi
    
    echo $php_version
}

function update_cli_php_version {
    # Update the PHP version for the CLI
    sudo update-alternatives --set php /usr/bin/php$1
}

function get_project_name {
    # get path to current directory
    project_name=$(basename "$(pwd)")
    
    # see if a nginx config exist with the same name as the project
    if [ ! -f /etc/nginx/sites-available/$project_name ]; then
        echo "Not in project folder" >&2
        # ask user to enter site name
        read -p "Enter the nginx site name. " project_name
    fi

    echo $project_name
}