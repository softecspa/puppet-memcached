# == Define memcached::client
#
# create memcahed instances
#
# [*daemons*]
#   hostname or array of hostnames used to reach memcached instances.
#
# [*daemons_ports*]
#   port or array of ports on which create instances. More than one port will means thath more than one instances will be created of each hostname specified in <daemons>. Default: [ 11211 ]
#
# [*dimension*]
#   portion of memory assigned to instance. Default: 128
#
define memcached::client (
  $daemons,
  $daemons_ports= ['11211'],
  $dimension    = '128',
) {

  $daemons_array = is_array($daemons)? {
    true  => $daemons,
    false => [ $daemons ]
  }

  $daemons_w_suffix= regsubst($daemons_array,'$',"---${name}---")

  $ports=is_array($daemons_ports)? {
    true  => $daemons_ports,
    false => [$daemons_ports]
  }

  memcached::ports { $daemons_w_suffix :
    ports     => $ports,
    dimension => $dimension
  }
}
