# @summary Kerberos configuration files for primary KDCs
#
# @example
#   include profile_kerberos_server::primary::config
#
class profile_kerberos_server::primary::config (
  String $kadm_acl_contents,
) {

  file { '/var/kerberos/krb5kdc/kadm5.acl':
    content => $kadm_acl_contents,
    mode    => '0600',
    notify  => [
      Service['krb5kdc'],
    ],
  }

  file { 'primary-/var/kerberos/krb5kdc/kpropd.acl':
    ensure => 'absent',
    path   => '/var/kerberos/krb5kdc/kpropd.acl',
  }

}
