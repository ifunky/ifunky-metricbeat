# Role class
#
# @example when declaring the class
#   class { 'role' }
#
# @author Dan
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

  exec { "unzip ${filename}":
    command  => "Add-Type -Assembly System.IO.Compression.FileSystem;\$zip = [IO.Compression.ZipFile]::OpenRead('${metricbeat::tmp_dir}/${filename}.zip');\$zip.Entries | where {\$_.Name -ne ''} | foreach {[System.IO.Compression.ZipFileExtensions]::ExtractToFile(\$_, \"${metricbeat::install_dir}\\$(\$_.Name)\", \$true)};\$zip.Dispose()",
    creates  => "${metricbeat::install_dir}/metricbeat.exe",
    logoutput => true,
    provider => powershell,
    require  => [ File[$metricbeat::install_dir], Remote_file["${metricbeat::tmp_dir}/${filename}.zip"],
    ],
  }
}
