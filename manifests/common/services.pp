# @summary Configure services for Kerberos server
#
# @param packages_absent
#   List of packages to ensure absent
#
# @param packages_present
#   List of packages to ensure present
#
# @example
#   include profile_kerberos_server::common::services
#
class profile_kerberos_server::common::services (
  Array[String] $packages_absent,
  Array[String] $packages_present,
) {
  ensure_packages($packages_present, { 'ensure' => 'present' })
  ensure_packages($packages_absent, { 'ensure' => 'absent' })

  service { 'krb5kdc':
    ensure => running,
    enable => true,
  }

# THE rsyslog CONFIG RULES SHOULD BE ADDED VIA UPDATING HIERA DATA FOR THE KERBEROS ROLE
#   I.E. profile_rsyslog::config_rulesets
#  file { '/etc/rsyslog.d/rsyslog-kdc.conf':
#    source => "puppet:///modules/${module_name}/etc/rsyslog.d/rsyslog-kdc.conf",
#    mode   => '0644',
#    notify => [
#      Service['rsyslog'],
#    ],
#  }
}
