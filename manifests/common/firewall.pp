# @summary Configure firewall rules for Kerberos services
#
# @example
#   include profile_kerberos_server::common::firewall
#
class profile_kerberos_server::common::firewall {

  # this should be port 88
  ['tcp','udp'].each |$protocol| {
    firewall { "210 Kerberos via ${protocol}":
      proto  => $protocol,
      dport  => [
        'kerberos',
      ],
      action => 'accept',
    }
  }

}
