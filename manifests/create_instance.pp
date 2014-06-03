define memcached::create_instance (
  $bind_address='',
  $dimension,
) {

  $port_host=regsubst($name,'^.*:','')
  $port=regsubst($port_host,'---.*---$','')

  if $bind_address == '' {
    fail('please, specify bind_address')
  }

  if !defined(Memcached::Instance[$port]) {
    memcached::instance { "$port":
      bind_address  => $bind_address,
      port          => $port,
      dimension     => $dimension,
    }
  }
}
