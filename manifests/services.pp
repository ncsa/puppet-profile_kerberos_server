# @summary Configure services for Kerberos server
#
# @param packages_absent
#   List of packages to ensure absent
#
# @param packages_present
#   List of packages to ensure present
#
# @example
#   include profile_kerberos_server::services
class profile_kerberos_server::services (
  Array[String] $packages_absent,
  Array[String] $packages_present,
) {

  ensure_packages($packages_present, {'ensure' => 'present'})
  ensure_packages($packages_absent, {'ensure' => 'absent'})

#NOTE:  This class' configuration of hosts.allow and hosts.deny could conflict with other
#       definitions for them in other classes.
  file { '/etc/hosts.allow':
    source => "puppet:///modules/${module_name}/etc/hosts.allow",
    mode   => '0644',
  }

  file { '/etc/hosts.deny':
    source => "puppet:///modules/${module_name}/etc/hosts.deny",
    mode   => '0644',
  }

  file { '/etc/xinetd.d/krb5-prop':
    source => "puppet:///modules/${module_name}/etc/xinetd.d/krb5-prop",
    mode   => '0644',
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

  service { 'xinetd':
    ensure => running,
    enable => true,
  }

  service { 'krb5kdc':
    ensure => running,
    enable => true,
  }

}
