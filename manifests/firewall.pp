# @summary Configure firewall rules for Kerberos services
#
# @param primary_server
#   FQDN of primary kerberos server
#
# @example
#   include profile_kerberos_server::firewall
class profile_kerberos_server::firewall (
  String $primary_server,
) {

  firewall { '1000 Kerberos krb5_prop via TCP':
    proto  => 'tcp',
    dport  => 'krb5_prop',
    source => $primary_server,
    action => 'accept',
  }

  firewall { '1010 Kerberos via TCP':
    proto  => 'tcp',
    dport  => [
      'kerberos',
    ],
    action => 'accept',
  }

  firewall { '1011 Kerberos via UDP':
    proto  => 'udp',
    dport  => [
      'kerberos',
    ],
    action => 'accept',
  }

}
