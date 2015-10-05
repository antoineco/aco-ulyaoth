# === Class: ulyaoth
#
# This module installs the Ulyaoth YUM repository and its dependencies
#
# == Parameters
#
# $gpgcheck:
#   enable or disable GPG signature check (valid: '0'|'1')
# $enable:
#   enable or disable the repository (valid: '0'|'1')
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
  $gpgcheck      = 1,
  $enable        = 1,
  $enable_debug  = 0,
  $enable_source = 0) {
  if $::osfamily == 'RedHat' {
    # define OS string
    $ostype = $::operatingsystem ? {
      'RedHat' => 'RHEL',
      default  => $::operatingsystem
    }

    # install YUM repositories
    Yumrepo {
      gpgcheck => $gpgcheck,
      gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-ulyaoth'
    }

    yumrepo {
      'ulyaoth':
        descr   => 'Ulyaoth Repository',
        baseurl => "https://repos.ulyaoth.net/${ostype}/\$releasever/\$basearch/os/",
        enabled => $enable;

      'ulyaoth-debug':
        descr   => 'Ulyaoth Repository (debug)',
        baseurl => "https://repos.ulyaoth.net/${ostype}/\$releasever/\$basearch/debug/",
        enabled => $enable_debug;

      'ulyaoth-source':
        descr   => 'Ulyaoth Repository (source)',
        baseurl => "https://repos.ulyaoth.net/${ostype}/\$releasever/\$basearch/source/",
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
