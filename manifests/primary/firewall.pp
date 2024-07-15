# @summary Configure firewall rules for Kerberos services
#
# @example
#   include profile_kerberos_server::primary::firewall
#
class profile_kerberos_server::primary::firewall (
  Array[String, 1] $kadmin_allow_cidr,
) {
  # kpasswd
  ['tcp','udp'].each |$protocol| {
    firewall { "212 kpasswd ${protocol}":
      proto  => $protocol,
      dport  => '464',
      action => 'accept',
    }
  }

  # kadmin
  $kadmin_allow_cidr.each |$cidr| {
    firewall { "213 kerberos-adm tcp ${cidr}":
      source => $cidr,
      proto  => 'tcp',
      dport  => '749',
      action => 'accept',
    }
  }
}
