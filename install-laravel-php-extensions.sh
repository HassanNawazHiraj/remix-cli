# enter php version
DIR="$(dirname "$0")"

source ${DIR}/functions.sh

php_version=$(select_php_version)

# List of required PHP packages
packages=(bcmath curl json mbstring mysql tokenizer xml zip opcache pdo calendar ctype exif ffi fileinfo ftp gettext iconv phar posix readline shmop sockets sysvmsg sysvsem sysvshm dom common)

# Loop over each package
for package in "${packages[@]}"; do
    # Check if the package is available with the php_version prefix
    if dpkg-query -Wf'${db:Status-abbrev}' "php${php_version}-${package}" 2>/dev/null | grep -q '^i'; then
        echo "Package php${php_version}-${package} is already installed"
    elif dpkg-query -l "php${php_version}-${package}" >/dev/null 2>&1; then
        # If the package is available but not installed, install it
        sudo apt install "php${php_version}-${package}"
    else
        # Check if the package is available without the php_version prefix
        if dpkg-query -Wf'${db:Status-abbrev}' "php-${package}" 2>/dev/null | grep -q '^i'; then
            echo "Package php-${package} is already installed"
        elif dpkg-query -l "php-${package}" >/dev/null 2>&1; then
            # If the package is available but not installed, install it
            sudo apt install "php-${package}"
        else
            # If the package is not available, skip it
            echo "Package php-${package} is not available, skipping"
        fi
    fi
done

# Enable the extensions
for package in "${packages[@]}"; do
    if ! php -m | grep -q "^${package}$"; then
        echo "Extension ${package} is not enabled, enabling"
        echo "extension=${package}.so" | sudo tee -a /etc/php/${php_version}/cli/php.ini
    fi
done

# Restart the PHP service to apply changes
sudo service php${php_version}-fpm restart