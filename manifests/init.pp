# Install and configure Metricbeat from Elasticsearch
#
# @example when declaring the class
#   class { 'template' }
#
# @param ensure Required. Must be 'present' or 'absent
# @param example_path Required.  Path to somewhere
#
# @author Dan @ iFunky.net
class metricbeat (
  String $install_dir          = $metricbeat::params::install_dir,
  String $tmp_dir              = $metricbeat::params::tmp_dir,
  String $proxy_address        = undef
) inherits metricbeat::params {

  class { '::metricbeat::install': } ->
  class { '::metricbeat::config': } ~>
  class { '::metricbeat::service': } ->
  Class['::metricbeat']

}
