# @summary Configure firewall rules for Kerberos services
#
# @example
#   include profile_kerberos_server::secondary::firewall
#
class profile_kerberos_server::secondary::firewall {

  $primary_server = lookup('profile_kerberos_server::primary_server')

  # this should be port 754
  firewall { '200 Kerberos krb5_prop via TCP':
    proto  => 'tcp',
    dport  => 'krb5_prop',
    source => $primary_server,
    action => 'accept',
  }

}
