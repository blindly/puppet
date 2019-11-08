# puppet module install puppet-nginx --version 1.0.0
# puppet module install puppet-php --version 7.0.0

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

$name = "vhost"
$domain = "155.138.196.253.xip.io"
$backend_port = 9000
$full_web_path = '/var/www/vhost'

nginx::resource::server { "${name}.${domain} ${name}":
  ensure                => present,
  listen_port           => 80,
  www_root              => $full_web_path,
  proxy                 => $proxy,
  location_cfg_append   => $location_cfg_append,
  index_files           => [ 'index.php' ],
}

nginx::resource::location { "${name}_root":
  ensure          => present,
  ssl             => true,
  ssl_only        => true,
  server           => "${name}.${::domain} ${name}",
  www_root        => "${full_web_path}/",
  location        => '~ \.php$',
  index_files     => ['index.php', 'index.html', 'index.htm'],
  proxy           => undef,
  fastcgi         => "127.0.0.1:${backend_port}",
  fastcgi_script  => undef,
  location_cfg_append => {
    fastcgi_connect_timeout => '3m',
    fastcgi_read_timeout    => '3m',
    fastcgi_send_timeout    => '3m'
  }
}