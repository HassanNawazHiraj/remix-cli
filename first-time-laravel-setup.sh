#!/bin/bash

DIR="$(dirname "$0")"
source ${DIR}/functions.sh

site_name=$(get_site_name)

# copy example .env.example to .env
cp /var/www/$site_name/.env.example /var/www/$site_name/.env

# generate application key
php /var/www/$site_name/artisan key:generate

# storage folder permissions
sudo chown -R www-data:www-data /var/www/$site_name/storage
sudo chown -R www-data:www-data /var/www/$site_name/bootstrap/cache
