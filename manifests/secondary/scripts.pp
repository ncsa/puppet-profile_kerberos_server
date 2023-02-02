# @summary Configure scripts for Kerberos services
#
# @example
#   include profile_kerberos_server::secondary::scripts
#
class profile_kerberos_server::secondary::scripts {

  file { '/var/kerberos/krb5kdc/propagate':
    ensure => 'absent'
  }

}
