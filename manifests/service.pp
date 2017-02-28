class metricbeat::service {

  service { 'metricbeat':
    ensure   => 'running',
    enable   => 'true',
  }

}