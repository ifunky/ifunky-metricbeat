# Install and configure Metricbeat from Elasticsearch
#
# @example when declaring the class
#   class { 'metricbeat' }
#
# @param ensure Required. Must be 'present' or 'absent
# @param example_path Required.  Path to somewhere
#
# @author Dan @ iFunky.net
class metricbeat (
  String  $install_dir       = $metricbeat::params::install_dir,
  String  $tmp_dir           = $metricbeat::params::tmp_dir,
  String  $beat_name         = $metricbeat::params::beat_name,
  String  $proxy_address     = undef,
  Hash    $modules           = $metricbeat::params::modules,
  Array   $tags              = $metricbeat::params::tags,
  Hash    $fields            = $metricbeat::params::fields,
  Boolean $fields_under_root = $metricbeat::params::fields_under_root,
  Hash    $outputs           = $metricbeat::params::outputs
) inherits metricbeat::params {

  class { '::metricbeat::install': } ->
  class { '::metricbeat::config': } ~>
  class { '::metricbeat::service': } ->
  Class['::metricbeat']

}
