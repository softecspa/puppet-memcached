define memcached::instance (
  $bind_address = "localhost",
  $port         = "11211",
  $dimension    = "128",
  $max_conn     = "1024") {

  include supervisor
  include memcached 

  supervisor::service { "memcache_${port}":
    ensure    => running,
    enable    => true,
    user      => "nobody",
    command   => "/usr/bin/memcached -u nobody -p ${port} -U 0 -m ${dimension} -l ${bind_address}",
    numprocs  => 1,
    require   => Class['memcached::install'],
  }

}
