# Class: memcached::install
#
#
class memcached::install {
	package { 'memcached':
		ensure => present,
	}
}
