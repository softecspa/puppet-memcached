# Class: memcached::config::redhat
#
#
class memcached::config::redhat {
	file { '/etc/sysconfig/memcached':
		ensure  => present,
		content => template('memcached/memcached.erb.redhat'),
		owner   => 'root',
		group   => 'root',
		mode    => '0644',
		notify  => Class['memcached::service'],
		require => Class['memcached::install'],
	}
}
