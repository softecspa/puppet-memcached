define memcached::import_resources (
  $bind_address,
) {

  Memcached::Create_instance <<| tag == $name |>> {
    bind_address  => $bind_address
  }

}
