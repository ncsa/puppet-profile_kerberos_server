# @summary Configure services for Kerberos server
#
# @example
#   include profile_kerberos_server::secondary::services
#
class profile_kerberos_server::secondary::services {
  # NOTE:  This class' configuration of hosts.allow and hosts.deny could conflict with other
  #       definitions for them in other classes.
  file { '/etc/hosts.allow':
    source => "puppet:///modules/${module_name}/etc/hosts.allow",
    mode   => '0644',
  }

  file { '/etc/hosts.deny':
    source => "puppet:///modules/${module_name}/etc/hosts.deny",
    mode   => '0644',
  }

  file { '/etc/xinetd.d/krb5-prop':
    source => "puppet:///modules/${module_name}/etc/xinetd.d/krb5-prop",
    mode   => '0644',
  }

  service { 'xinetd':
    ensure => running,
    enable => true,
  }

  service { 'kadmin':
    ensure => 'stopped',
  }
}
