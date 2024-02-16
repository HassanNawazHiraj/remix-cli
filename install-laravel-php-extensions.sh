# enter php version
source functions.sh

php_version=$(select_php_version)

sudo apt install openssl php${php_version}-bcmath php${php_version}-curl php${php_version}-json php${php_version}-mbstring php${php_version}-mysql php${php_version}-tokenizer php${php_version}-xml php${php_version}-zip
