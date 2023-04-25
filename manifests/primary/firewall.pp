# @summary Configure firewall rules for Kerberos services
#
# @example
#   include profile_kerberos_server::primary::firewall
#
class profile_kerberos_server::primary::firewall {

  # kpasswd
  ['tcp','udp'].each |$protocol| {
    firewall { "212 kpasswd ${protocol}":
      proto  => $protocol,
      dport  => '464',
      action => 'accept',
    }
  }

  # kadmin
  [
    '141.142.0.0/16',
    '10.142.0.0/16',
    '172.24.0.0/13',
    '172.16.0.0/13'
  ].each |$range| {
    firewall { "213 kerberos-adm tcp ${range}":
      source => $range,
      proto  => 'tcp',
      dport  => '749',
      action => 'accept',
    }
  }

}
