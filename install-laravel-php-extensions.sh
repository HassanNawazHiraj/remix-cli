# enter php version
DIR="$(dirname "$0")"

source ${DIR}/functions.sh

php_version=$(select_php_version)

update_cli_php_version $php_version

# List of required PHP packages
sudo apt install openssl php-bcmath php-curl php-json php-mbstring php-mysql php-tokenizer php-xml php-zip

sudo apt-get update

# Restart the PHP service to apply changes
sudo service php${php_version}-fpm restart