define memcached::monitoring (
  $host_port = '',
  $monitored_hostname = $::hostname,
  $nagios_hostname    = $::nagios_hostname
) {

  $real_host_port = $host_port? {
    ''      => $name,
    default => $host_port
  }

  $host = inline_template("<%= @real_host_port.split(':').at(0) %>")
  $port = inline_template("<%= @real_host_port.split(':').at(1) %>")

  @@nagios::check { "memcache-${host}-${port}-${::fqdn}":
    host                  => $monitored_hostname,
    checkname             => 'check_nrpe_1arg',
    service_description   => "memcache ${host} ${port}",
    target                => "memcache_${::hostname}.cfg",
    params                => "!check_memcache_${host}_${port}",
    tag                   => "nagios_check_memcache_${nagios_hostname}",
  }
}
