# munin plugins for puppet
class tor::munin {
  tor::daemon::control{
    'control_port_for_munin':
      port                  => 19051,
      cookie_authentication => 1,
      cookie_auth_file      => '/var/run/tor/control.authcookie',
  }

  Munin::Plugin::Deploy {
    config  => "user debian-tor\n env.cookiefile /var/run/tor/control.authcookie\n env.port 19051"
  }
  munin::plugin::deploy {
    'tor_openfds':
      config  => 'user root',
      source => 'tor/munin/tor_openfds';
    'tor_routers':
      source => 'tor/munin/tor_routers';
    'tor_traffic':
      source => 'tor/munin/tor_traffic';
  }
}
