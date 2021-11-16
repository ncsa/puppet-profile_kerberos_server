# @summary Configure firewall rules for Kerberos services
#
# @example
#   include profile_kerberos_server::firewall
class profile_kerberos_server::firewall {

#-A INPUT -p tcp -s brick.ncsa.uiuc.edu --dports krb5_prop -j ACCEPT
  firewall { '1000 Kerberos krb5_prop via TCP':
    proto  => 'tcp',
    dport  => 'krb5_prop',
    source => 'brick.ncsa.uiuc.edu',
    action => 'accept',
#    provider => 'iptables',
  }

# Don't need kpasswd on slaves, only on master
#-A INPUT -p all -m multiport --dports kerberos,kpasswd -j ACCEPT
  firewall { '1010 Kerberos via TCP':
    proto    => 'tcp',
    dport    => [
      'kerberos',
#      'kpasswd',
    ],
    action   => 'accept',
    provider => 'iptables',
  }

# Don't need kpasswd on slaves, only on master
#-A INPUT -p all -m multiport --dports kerberos,kpasswd -j ACCEPT
  firewall { '1011 Kerberos via UDP':
    proto    => 'udp',
    dport    => [
      'kerberos',
#      'kpasswd',
    ],
    action   => 'accept',
    provider => 'iptables',
  }

}
