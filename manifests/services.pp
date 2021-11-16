# @summary Configure services for Kerberos server
#
# @example
#   include profile_kerberos_server::services
class profile_kerberos_server::services {

  $packages_present = [
    'bind-utils',
    'cracklib-devel',
    'krb5-server',
    'mlocate',
    'perl-MailTools',
    'tcp_wrappers',
    'xinetd',
  ]

  $packages_absent = [
    'avahi',
    'avahi-autoipd',
    'NetworkManager',
    'NetworkManager-adsl',
    'NetworkManager-bluetooth',
    'NetworkManager-ppp',
    'NetworkManager-team',
    'NetworkManager-tui',
    'NetworkManager-wifi',
    'NetworkManager-wwan',
  ]

  ensure_packages($packages_present, {'ensure' => 'present'})
  ensure_packages($packages_absent, {'ensure' => 'absent'})

#NOTE:  This class' configuration of hosts.allow and hosts.deny could conflict with other
#       definitions for them in other classes.
  file { '/etc/hosts.allow':
    source => 'puppet:///modules/kerberos_server/etc/hosts.allow',
    mode   => '0644',
  }

  file { '/etc/hosts.deny':
    source => 'puppet:///modules/kerberos_server/etc/hosts.deny',
    mode   => '0644',
  }

  file { '/etc/xinetd.d/krb5-prop':
    source => 'puppet:///modules/kerberos_server/etc/xinetd.d/krb5-prop',
    mode   => '0644',
  }

  file { '/etc/rsyslog.d/rsyslog-kdc.conf':
    source => 'puppet:///modules/kerberos_server/etc/rsyslog.d/rsyslog-kdc.conf',
    mode   => '0644',
  }

  service { 'xinetd':
    ensure => running,
    enable => true,
  }

  service { 'krb5kdc':
    ensure => running,
    enable => true,
  }

}
