# @summary Configure services for Kerberos server
#
# @example
#   include profile_kerberos_server::primary::services
#
class profile_kerberos_server::primary::services {

  service { 'kadmin':
    ensure => running,
    enable => true,
  }

}
