class metricbeat::install::windows () {

  $filename = regsubst($metricbeat::download_url, '^https?.*\/([^\/]+)\.[^.].*', '\1')
  $foldername = 'Metricbeat'

  file { $metricbeat::install_dir:
    ensure => directory,
  }

  remote_file {"${metricbeat::tmp_dir}/${filename}.zip":
    ensure      => present,
    source      => $metricbeat::download_url,
    verify_peer => false,
    proxy       => $metricbeat::proxy_address,
  }

  exec { "Unzip Metricbeat":
    command  => "Add-Type -Assembly System.IO.Compression.FileSystem;\$zip = [IO.Compression.ZipFile]::OpenRead('${metricbeat::tmp_dir}/${filename}.zip');\$zip.Entries | where {\$_.Name -ne ''} | foreach {[System.IO.Compression.ZipFileExtensions]::ExtractToFile(\$_, \"${metricbeat::install_dir}\\$(\$_.Name)\", \$true)};\$zip.Dispose()",
    creates  => "${metricbeat::install_dir}/metricbeat.exe",
    logoutput => true,
    provider => powershell,
    require  => [ File[$metricbeat::install_dir], Remote_file["${metricbeat::tmp_dir}/${filename}.zip"] ],
  }

  exec { "Install Metricbeat service":
    cwd      => $metricbeat::install_dir,
    command  => './install-service-metricbeat.ps1',
    onlyif   => 'if(Get-WmiObject -Class Win32_Service -Filter "Name=\'metricbeat\'") { exit 1 } else {exit 0 }',
    provider =>  powershell,
    require  => Exec['Unzip Metricbeat'],
  }
}
