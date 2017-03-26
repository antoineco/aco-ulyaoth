# === Class: ulyaoth
#
# This module installs the Ulyaoth YUM repository and its dependencies
#
# == Parameters
#
# [*gpgcheck*]
#   enable or disable GPG signature check (valid: '0'|'1')
# [*enable*]
#   enable or disable the repository (valid: '0'|'1')
# [*enable_debug*]
#   enable or disable the debug repository (valid: '0'|'1')
# [*enable_source*]
#   enable or disable the source repository (valid: '0'|'1')
# [*proxy*]
#   url of a proxy server that yum should use when accessing these repositories
# [*proxy_username*]
#   user name for the proxy
# [*proxy_password*]
#   password for the proxy
#
# === Actions
#
# - Install Ulyaoth YUM repository
#
# === Requires
#
# (none)
#
# === Sample Usage:
#
# class { '::ulyaoth':
#   gpgcheck => '1',
#   enable   => '1'
#}
#
class ulyaoth (
  $gpgcheck       = 1,
  $enable         = 1,
  $enable_debug   = 0,
  $enable_source  = 0,
  $proxy          = absent,
  $proxy_username = absent,
  $proxy_password = absent) {
  if $::osfamily == 'RedHat' {
    # define OS string
    $ostype = $::operatingsystem ? {
      'Scientific' => 'scientificlinux',
      'Amazon'     => 'amazonlinux',
      default      => $::operatingsystem
    }

    # install YUM repositories
    Yumrepo {
      gpgcheck       => $gpgcheck,
      gpgkey         => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-ulyaoth',
      proxy          => $proxy,
      proxy_username => $proxy_username,
      proxy_password => $proxy_password
    }

    yumrepo {
      'ulyaoth':
        descr   => 'Ulyaoth Repository',
        baseurl => "https://repos.ulyaoth.io/${ostype}/\$releasever/\$basearch/os/",
        enabled => $enable;

      'ulyaoth-debug':
        descr   => 'Ulyaoth Repository (Debug)',
        baseurl => "https://repos.ulyaoth.io/${ostype}/\$releasever/\$basearch/debug/",
        enabled => $enable_debug;

      'ulyaoth-source':
        descr   => 'Ulyaoth Repository (Source)',
        baseurl => "https://repos.ulyaoth.io/${ostype}/\$releasever/\$basearch/source/",
        enabled => $enable_source
    }

    # install GPG key
    file { '/etc/pki/rpm-gpg/RPM-GPG-KEY-ulyaoth':
      ensure => present,
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
      source => "puppet:///modules/${module_name}/RPM-GPG-KEY-ulyaoth",
    }

    ulyaoth::rpm_gpg_key { 'Ulyaoth GPG key':
      path => '/etc/pki/rpm-gpg/RPM-GPG-KEY-ulyaoth'
    }
  } else {
    fail("Unsupported operating system family ${::osfamily}")
  }
}
