# Class: memcached::service
#
#
class memcached::service {
	service { 'memcached':
		ensure     => running,
		enable     => true,
		hasrestart => true,
    status     => "cat /var/run/memcached.pid | xargs ps -p",
		require    => Class["memcached::config::${memcached::params::os_suffix}"],
	}
}

# abilita il servizio
class memcached::service::enabled inherits memcached::service {
    # default
}

# disabilita il servizio allo startup
class memcached::service::disabled inherits memcached::service {
    Service["memcached"] {
        ensure      => stopped,
        enable      => false,
        #provider    => debian,
    }
}
