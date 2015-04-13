# === Class: ulyaoth
#
# This module installs the Ulyaoth YUM repository and its dependencies on RHEL-variants
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
class ulyaoth ($gpgcheck = 1, $enable = 1) {
  if ($::osfamily == 'RedHat') and ($::architecture == 'x86_64') {
    # define OS string
    $ostype = $::operatingsystem ? {
      'Fedora' => 'Fedora',
      default  => 'RHEL'
    }

    # install YUM repositories
    yumrepo { 'ulyaoth':
      descr    => 'Ulyaoth Repository',
      baseurl  => "https://repos.ulyaoth.net/${ostype}/\$releasever/\$basearch/os/",
      enabled  => $enable,
      gpgcheck => $gpgcheck,
      gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-ulyaoth'
    }

    # install GPG key
    file { '/etc/pki/rpm-gpg/RPM-GPG-KEY-ulyaoth':
      ensure => present,
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
      source => "puppet:///modules/${module_name}/RPM-GPG-KEY-ulyaoth",
    }

    ulyaoth::rpm_gpg_key { 'Ulyaoth GPG key': path => '/etc/pki/rpm-gpg/RPM-GPG-KEY-ulyaoth' }
  } else {
    fail("Unsupported operating system family ${::osfamily}")
  }
}
