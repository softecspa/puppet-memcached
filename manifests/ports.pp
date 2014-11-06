define memcached::ports (
  $ports,
  $dimension,
) {

  $host=regsubst($name,'--.*--$','')
  $host_ports= regsubst($ports,'^',"${host}:")
  $host_ports_hostname = regsubst($host_ports,'$',"---$hostname---")

  @@memcached::create_instance{ $host_ports_hostname :
    dimension   => $dimension,
    tag         => $host,
  }

  nrpe::check_memcache_reachable {$host_ports :}
  nrpe::check_memcache {$host_ports :}

  # richiamare una classe monitoring che contempli più porte
  memcached::monitoring {$host_ports:}

}
