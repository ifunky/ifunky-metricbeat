class metricbeat::install {

  case $::kernel {
    'Linux':   {
      class{ '::metricbeat::install::linux': }
    }
    'Windows': {
      class{'::metricbeat::install::windows': }
    }
    default:   {
      fail('')
    }
  }

}