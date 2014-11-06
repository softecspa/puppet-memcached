# Class: memcached::install
#
#
class memcached::install {
	package { 'memcached':
		ensure => present,
	}

  package { 'libcache-memcached-perl':
    ensure => present,
  }
}
