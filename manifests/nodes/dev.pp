node 'blog-dev.example.com' {
  file { '/tmp/nginx_signing.key':
    source => 'puppet:///modules/security/nginx_signing.key',
  }

  exec { 'nginx-key':
    command      => '/usr/bin/apt-key add /tmp/nginx_signing.key',
    subscribe    => File['/tmp/nginx_signing.key'],
    refreshonly => true,
  }

  apt::source { "nginx":
    location          => "http://nginx.org/packages/ubuntu/",
    release           => "precise",
    repos             => "nginx",
    include_src       => true,
    require           => Exec['nginx-key']
  }

  class { 'nginx':
    require => Apt::Source["nginx"],
    puppi    => true,
  }

  file { ['/var/www', '/etc/nginx/sites-enabled', '/etc/nginx/sites-available']:
    ensure => 'directory'
  }

  puppi::project::git { "blog":
    source      => "git://github.com/mojombo/mojombo.github.io.git",
    deploy_root => "/usr/share/nginx/html",
    require     => File['/var/www'],
    notify => Exec['clean blog']
  }

  exec { 'clean blog':
    command => '/bin/rm -rf /usr/share/nginx/html/*',
    # refreshonly => true
  }

  nginx::vhost { 'blog.com' :
    docroot  => '/var/www/blog',
    require  => [File['/etc/nginx/sites-enabled'], File['/etc/nginx/sites-available']]
  }
}

