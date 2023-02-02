# @summary Configure scripts for Kerberos services
#
# @example
#   include profile_kerberos_server::primary::scripts
#
class profile_kerberos_server::primary::scripts {

  file { '/var/kerberos/krb5kdc/propagate':
    source => "puppet:///modules/${module_name}/var/kerberos/krb5kdc/propagate",
    mode   => '0700',
  }

}
