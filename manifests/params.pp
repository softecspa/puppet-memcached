# Class: memcached::params
#
#
class memcached::params {
	# TODO: refactor this var to a common module and make other module use it
	$os_suffix = $operatingsystem ? {
		/(?i)(Debian|Ubuntu)/ => 'debian',
		/(?i)(RedHat|CentOS|Linux)/ => 'redhat',
	}
	
	# The port we listen to (default is 11211)
	$port = $memcached_port ? {
		''      => '11211',
		default => $memcached_port,
	}
	
	# The user which run under
	$user = $operatingsystem ? {
		/(?i)(Debian|Ubuntu)/ => 'nobody',
		/(?i)(RedHat|CentOS|Linux)/ => 'memcached',
	}
	
	# The max number of simultaneous incoming connections. The daemon default is 1024.
	# Note that the daemon will grow to this size, but does not start out holding this much
	# memory
	$max_conn = $memcached_max_conn ? {
		''      => '1024',
		default => $memcached_max_conn,
	}
	
	# The amount of memory we use for caching. The default is 64MB. 
	$cache_size = $memcached_cache_size ? {
		''      => '64',
		default => $memcached_cache_size,
	}
	
	# These are Debian/Ubuntu specific tunables.
	# TODO: see if we can make RedHat/CentOS
	$logfile = $memcached_logfile ? {
		''      => '/var/log/memcached.log',
		default => $memcached_logfile,
	}
	
	$verbosity = $memcached_verbosity ? {
		'0'     => '0',
		'1'     => '1',
		'2'     => '2',
		default => '0',
	}
	
	# The network interface to use for memcached
	$listen_on = $memcached_listen_on ? {
		''      => '127.0.0.1',
		default => $memcached_listen_on,
	}
	
	# Lock down all paged memory. Consult with the README and homepage before you do this
	$lock_down_paged_memory = $memcached_lock_down_paged_memory ? {
		'true'  => true,
		'false' => false,
		default => false,
	}
	
	# Return error when memory is exhausted (rather than removing items)
	$error_on_memory_exhaustion = $memcached_error_on_memory_exhaustion ? {
		'true'  => true,
		'false' => false,
		default => false,
	}
	
	# Maximize core file limit
	$maximize_core_file_limit = $memcached_maximize_core_file_limit ? {
		'true'  => true,
		'false' => false,
		default => false,
	}

    # service startup
    $startup = $memcached_startup ? {
        ""      => "disabled",
        "true"  => "enabled",
        "false" => "disabled",
        default => "disabled",
    }
}
