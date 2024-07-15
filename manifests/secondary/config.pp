# @summary Kerberos configuration files for secondary KDCs
#
# @example
#   include profile_kerberos_server::secondary::config
#
class profile_kerberos_server::secondary::config {
  # make sure kadm5.acl doesn't exist so we don't accidentally write to a secondary KDC database
  file { 'secondary-/var/kerberos/krb5kdc/kadm5.acl':
    ensure => 'absent',
    path   => '/var/kerberos/krb5kdc/kadm5.acl',
  }

  # accept propagation from the primary KDC and restart service if this file changes
  file { 'secondary-/var/kerberos/krb5kdc/kpropd.acl':
    path   => '/var/kerberos/krb5kdc/kpropd.acl',
    source => "puppet:///modules/${module_name}/var/kerberos/krb5kdc/kpropd.acl",
    mode   => '0644',
    notify => [
      Service['krb5kdc'],
    ],
  }
}
