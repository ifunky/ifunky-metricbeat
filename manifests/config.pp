class metricbeat::config {

  $modules            = $metricbeat::modules
  $beat_name          = $metricbeat::beat_name
  $tags               = $metricbeat::tags
  $fields             = $metricbeat::fields
  $fields_under_root  = $metricbeat::fields_under_root
  $outputs            = $metricbeat::outputs
  $metricbeat_path    = "${metricbeat::install_dir}/metricbeat.exe"

  file { "${metricbeat::install_dir}/metricbeat.yml":
    ensure       => file,
    content      => template('metricbeat/metricbeat.yml.erb'),
    validate_cmd => "\"${metricbeat_path}\" -N -configtest -c \"%\"",
  }
}