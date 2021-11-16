# @summary Configure scripts for Kerberos services
#
# @example
#   include profile_kerberos_server::scripts
class profile_kerberos_server::scripts {

# Make daily backup of propagated database on local disk
# 03 04 * * * /usr/local/scripts/krb5_ss_backup.pl
  cron { 'ss_backup':
    command     => '/usr/local/scripts/krb5_ss_backup.pl',
    user        => 'root',
    hour        => 4,
    minute      => 3,
    environment => ['SHELL=/bin/sh', 'MAILTO=kerberos-admin@ncsa.uiuc.edu'],
  }

# Roll the kerberos logs to AFS
# 0 0 * * * /usr/local/scripts/mv_krb5_log > /dev/null 2>&1
  cron { 'mv_krb5_log':
    command     => '/usr/local/scripts/mv_krb5_log',
    user        => 'root',
    hour        => 0,
    minute      => 0,
    environment => ['SHELL=/bin/sh', 'MAILTO=kerberos-admin@ncsa.uiuc.edu'],
  }

# Roll the syslogs to AFS
# 0 1 * * * /usr/local/scripts/mv_syslogs > /dev/null 2>&1
  cron { 'mv_syslogs':
    command     => '/usr/local/scripts/mv_syslogs',
    user        => 'root',
    hour        => 0,
    minute      => 1,
    environment => ['SHELL=/bin/sh', 'MAILTO=kerberos-admin@ncsa.uiuc.edu'],
  }

  ## Copy over the kerberos server configuration files (NOT .k5.NCSA.EDU, it must be hand copied)
  file { '/var/kerberos/krb5kdc/':
    ensure => 'directory',
    owner  => 'root',
    mode   => '0755',
  }

  ## Copy over the kerberos server configuration files (NOT .k5.NCSA.EDU, it must be hand copied)
  file { '/var/kerberos/krb5kdc/backups':
    ensure => 'directory',
    owner  => 'root',
    mode   => '0755',
  }

  file { '/var/kerberos/krb5kdc/cracklib-words':
    source => 'puppet:///modules/kerberos_server/var/kerberos/krb5kdc/cracklib-words',
    mode   => '0644',
  }

  file { '/var/kerberos/krb5kdc/kadm5.acl':
    source => 'puppet:///modules/kerberos_server/var/kerberos/krb5kdc/kadm5.acl',
    mode   => '0600',
  }

  file { '/var/kerberos/krb5kdc/kdc.conf':
    source => 'puppet:///modules/kerberos_server/var/kerberos/krb5kdc/kdc.conf',
    mode   => '0600',
  }

  file { '/var/kerberos/krb5kdc/kpropd.acl':
    source => 'puppet:///modules/kerberos_server/var/kerberos/krb5kdc/kpropd.acl',
    mode   => '0644',
  }

  ## Copy over scripts run at startup and scripts run by cron.

  file { '/usr/local/scripts/':
    ensure => 'directory',
    owner  => 'root',
    mode   => '0755',
  }

  file { '/usr/local/scripts/krb5_passwd_check':
    source => 'puppet:///modules/kerberos_server/usr/local/scripts/krb5_passwd_check',
    mode   => '0755',
  }

  file { '/usr/local/scripts/krb5_sm_backup.pl':
    source => 'puppet:///modules/kerberos_server/usr/local/scripts/krb5_sm_backup.pl',
    mode   => '0755',
  }

  file { '/usr/local/scripts/krb5_ss_backup.pl':
    source => 'puppet:///modules/kerberos_server/usr/local/scripts/krb5_ss_backup.pl',
    mode   => '0755',
  }

  file { '/usr/local/scripts/mv_krb5_log':
    source => 'puppet:///modules/kerberos_server/usr/local/scripts/mv_krb5_log',
    mode   => '0700',
  }

  file { '/usr/local/scripts/mv_syslogs':
    source => 'puppet:///modules/kerberos_server/usr/local/scripts/mv_syslogs',
    mode   => '0700',
  }

  file { '/usr/local/scripts/watchafsbackup.pl':
    source => 'puppet:///modules/kerberos_server/usr/local/scripts/watchafsbackup.pl',
    mode   => '0755',
  }

  file { '/usr/local/scripts/watchlogins.pl':
    source => 'puppet:///modules/kerberos_server/usr/local/scripts/watchlogins.pl',
    mode   => '0700',
  }

}
