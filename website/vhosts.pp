class {'apache': }

class { '::php::globals':
  php_version => '7.0',
  config_root => '/etc/php/7.0',
}->
class { '::php':
  ensure       => latest,
  manage_repos => true,
  fpm          => true,
  dev          => true,
  composer     => true,
  pear         => true,
  phpunit      => false,
}

apache::vhost { 'vhost.155.138.196.253.xip.io':
  port    => '80',
  docroot => '/var/www/vhost',
}

apache::vhost { 'vhost1.155.138.196.253.xip.io':
  port    => '80',
  docroot => '/var/www/vhost',
}

apache::vhost { 'vhost2.155.138.196.253.xip.io':
  port    => '80',
  docroot => '/var/www/vhost',
}


file {'/var/www/vhost/index.html': 
  content => "It works";
}