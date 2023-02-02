# @summary Kerberos configuration files for primary KDCs
#
# @example
#   include profile_kerberos_server::primary::config
#
class profile_kerberos_server::primary::config {

  file { '/var/kerberos/krb5kdc/kadm5.acl':
    source => "puppet:///modules/${module_name}/var/kerberos/krb5kdc/kadm5.acl",
    mode   => '0600',
    notify => [
      Service['krb5kdc'],
    ],
  }

  file { 'primary-/var/kerberos/krb5kdc/kpropd.acl':
    ensure => 'absent',
    path   => '/var/kerberos/krb5kdc/kpropd.acl',
  }

}
