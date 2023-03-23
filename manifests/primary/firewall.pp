# @summary Configure firewall rules for Kerberos services
#
# @example
#   include profile_kerberos_server::primary::firewall
#
class profile_kerberos_server::primary::firewall {

  # This should be kadmin and kpasswd
  ['tcp','udp'].each |$protocol| {

    firewall { "212 Kerberos via ${protocol}":
      proto  => $protocol,
      dport  => [
        '464',
        '749',
      ],
      action => 'accept',
    }
  }

}
