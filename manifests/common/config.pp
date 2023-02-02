# @summary common Kerberos configuration files 
#
# @example
#   include profile_kerberos_server::common::config
#
class profile_kerberos_server::common::config {

  ## Copy over the kerberos server configuration files (NOT .k5.NCSA.EDU, it must be hand copied)
  file { '/var/kerberos/krb5kdc/':
    ensure => 'directory',
    owner  => 'root',
    mode   => '0755',
  }

  file { '/var/kerberos/krb5kdc/backups':
    ensure => 'directory',
    owner  => 'root',
    mode   => '0755',
  }

  file { '/var/kerberos/krb5kdc/cracklib-words':
    source => "puppet:///modules/${module_name}/var/kerberos/krb5kdc/cracklib-words",
    mode   => '0644',
  }

  file { '/var/kerberos/krb5kdc/kdc.conf':
    source => "puppet:///modules/${module_name}/var/kerberos/krb5kdc/kdc.conf",
    mode   => '0600',
    notify => [
      Service['krb5kdc'],
    ],
  }

}
