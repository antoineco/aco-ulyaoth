# === Define ulyaoth::rpm_gpg_key
#
# == Parameters
#
# $path:
#   path of the RPM GPG key to import
#
# === Actions:
#
# - Import a RPM gpg key
#
# === Requires
#
# (none)
#
# === Sample Usage:
#
# ulyaoth::rpm_gpg_key{ "Ulyaoth":
#   path => "/etc/pki/rpm-gpg/RPM-GPG-KEY-ulyaoth"
#}
#
define ulyaoth::rpm_gpg_key ($path) {
  # Given the path to a key, see if it is imported, if not, import it
  exec { "import-${name}":
    path      => '/bin:/usr/bin:/sbin:/usr/sbin',
    command   => "rpm --import ${path}",
    unless    => "rpm -q gpg-pubkey-$(echo $(gpg --throw-keyids < ${path}) | cut --characters=11-18 | tr '[A-Z]' '[a-z]')",
    require   => File[$path],
    logoutput => 'on_failure',
  }
}