class {'apache': }

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