# @summary Configure firewall rules for Kerberos services
#
# @example
#   include profile_kerberos_server::primary::firewall
#
class profile_kerberos_server::primary::firewall {

  # This should be port 464 and 749
  ['tcp','udp'].each |$protocol| {

    firewall { "212 Kerberos via ${protocol}":
      proto  => $protocol,
      dport  => [
        'kadmin',
        'kpasswd',
      ],
      action => 'accept',
    }
  }

}
