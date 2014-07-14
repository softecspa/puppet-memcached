# == Class memcached
# This module install memcached package and create memcached instances based on supervisor.
# It can creates a single instance through define memcached::instance or import instaces defined on client side through memcached::client or memcached::ispconfig_client defines
#
# === Parameters
# [*bind_address*]
#   ip_address on which imported instances have to bind. If you set <memcached_hostnames> parameter, bind_address become mandatory. If you don't set <memcached_hostnames>,
#   bind_address will not be used because no instances are automatically created.
#
# [*memcached_hostnames*]
#   hostname used to reach memcached instances by clients. If this parameter is set, the class import every instances requested by clients on this address
#
# === Examples
# 1) simply install memcached
#
#   node foo.example.com {
#     include memcached
#   }
#
# 2) install memcached and create instance on 127.0.0.1:11211. Check memcached::instance doc to see explaination of other parameters.
#   node foo.example.com {
#     memcached::instance {'bar':
#       bind_address = "127.0.0.1",
#       port         = "11211",
#     }
#   }
#
# 3) Suppose to have a server named bar01 and we want to have two memcached instances available on servers bar-cache01.example.com and bar-cache02.example.com. Memcached
#    instances will bind on memcache01.backplane and memcache02.backplane address. By default instances will be created on 11211 port
#
#   # step1: on the frontend we define the instance:
#   node bar01.example.com {
#     memcached::client {'bar':
#       daemons       => [ 'memcache01.backplane', 'memcache02.backplane' ],
#     }
#   }
#
#   # step2: on the memcache nodes import and creates instances
#   node bar-cache01.example.com {
#     class {'memcached':
#       bind_address         => 'x.x.x.x', #(ip address of memcache01.backplane)
#       memcached_hostnames  => 'memcache01.backplane'
#     }
#   }
#
#   node bar-cache02.example.com {
#     class {'memcached':
#       bind_address         => 'y.y.y.y', #(ip address of memcache02.backplane)
#       memcached_hostnames  => 'memcache02.backplane'
#     }
#   }
#
class memcached (
  $bind_address         = '',
  $memcached_hostnames  = '',
) {
	require memcached::params
	include memcached::install
  include "memcached::config::${memcached::params::os_suffix}"
  include "memcached::service::${memcached::params::startup}"

  Class['memcached::install'] ->
  Class["memcached::config::${memcached::params::os_suffix}"] ->
  Class["memcached::service::${memcached::params::startup}"]

  if $memcached_hostnames !='' {
    if $bind_address == '' {
      fail('if you specify memcached_hostname parameter, you have to define also bind_address')
    }

    memcached::import_resources { $memcached_hostnames :
      bind_address  => $bind_address
    }
  }
}
