# enter php version
DIR="$(dirname "$0")"

source ${DIR}/functions.sh

php_version=$(select_php_version)

# List of required PHP packages
packages=(bcmath curl json mbstring mysql tokenizer xml zip opcache pdo calendar ctype exif ffi fileinfo ftp gettext iconv phar posix readline shmop sockets sysvmsg sysvsem sysvshm dom)

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
        if dpkg-query -Wf'${db:Status-abbrev}' "${package}" 2>/dev/null | grep -q '^i'; then
            echo "Package ${package} is already installed"
        elif dpkg-query -l "${package}" >/dev/null 2>&1; then
            # If the package is available but not installed, install it
            sudo apt install "${package}"
        else
            # If the package is not available, skip it
            echo "Package ${package} is not available, skipping"
        fi
    fi
done