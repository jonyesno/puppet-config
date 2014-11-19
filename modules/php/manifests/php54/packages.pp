class php::php54::packages {
  package { [
    'php',
    'php-bcmath',
    'php-cli',
    'php-common',
    'php-dba',
    'php-devel',
    'php-enchant',
    'php-fpm',
    'php-gd',
    'php-intl',
    'php-mbstring',
    'php-mcrypt',
    'php-mysql',
    'php-pdo',
    'php-process',
    'php-pspell',
    'php-recode',
    'php-tidy',
    'php-xml',
    'php-xmlrpc',
    ]: ensure => latest }
}
