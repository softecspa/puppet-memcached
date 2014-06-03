# Class: memcached::config::debian
#
#
class memcached::config::debian {
	file { '/etc/default/memcached':
		ensure  => present,
		content => template('memcached/memcached.erb.debian'),
		owner   => 'root',
		group   => 'root',
		mode    => '0644',
		notify  => Class['memcached::service'],
		require => Class['memcached::install'],
	}

	file { '/etc/memcached.conf':
		ensure  => present,
		content => template('memcached/memcached.conf.erb'),
		owner   => 'root',
		group   => 'root',
		mode    => '0644',
		notify  => Class['memcached::service'],
		require => Class['memcached::install'],
	}
}
