# Default params for Metricbeat
#
class metricbeat::params {
  $beat_name              = $::fqdn
  $fields_under_root      = true
  $elasticsearch_enabled  = true
  $modules                = {}
  $tags                   = []
  $fields                 = {}
  $outputs                = {}
  case $::kernel {
    'Linux'   : {
      $config_file     = '/etc/metricbeat/metricbeat.yml'

      $tmp_dir         = '/tmp'
      $install_dir     = undef
      $download_url    = undef
      case $::osfamily {
        'RedHat': {
          $service_provider = 'redhat'
        }
        default: {
          $service_provider = undef
        }
      }
    }

    'Windows' : {
      $config_file      = 'C:/Program Files/Metricbeat/metricbeat.yml'
      $download_url     = 'https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-5.2.1-windows-x86_64.zip'
      $install_dir      = 'C:/Program Files/Metricbeat'
      $tmp_dir          = 'C:/Windows/Temp'
    }

    default : {
      fail("${::kernel} is not supported.  Feel free to add it and do a pull request!")
    }
  }
}