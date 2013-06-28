import 'nodes/*'

node default {
  class { "ntp":
      servers      => [ 'time.apple.com' ],
        autoupdate => false,
  }

  class { 'apt':
    always_apt_update    => false,
    disable_keys         => undef,
    proxy_host           => false,
    proxy_port           => '8080',
    purge_sources_list   => false,
    purge_sources_list_d => false,
    purge_preferences_d  => false
  }

}
