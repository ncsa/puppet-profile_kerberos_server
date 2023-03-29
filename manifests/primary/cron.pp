# @summary Kerberos primary KDC cron entries
#
# @example
#   include profile_kerberos_server::primary::cron
#
class profile_kerberos_server::primary::cron {

  # Propagate the database to secondary KDCs every five minutes
  # */5 * * * * /var/kerberos/krb5kdc/propagate
  cron { 'propagate':
    command     => '/var/kerberos/krb5kdc/propagate > /dev/null 2>&1',
    user        => 'root',
    hour        => '*',
    minute      => '*/5',
    environment => ['SHELL=/bin/sh', 'MAILTO=kerberos-admin@ncsa.uiuc.edu'],
    #description => 'Propagate the database to secondary KDCs every five minutes'
  }

  # Make daily backup of propagated database on local disk
  # 03 04 * * * /root/cron_scripts/krb5_sm_backup.pl
  cron { 'sm_backup':
    command     => '/root/cron_scripts/krb5_sm_backup.pl',
    user        => 'root',
    hour        => '03',
    minute      => '04',
    environment => ['SHELL=/bin/sh', 'MAILTO=kerberos-admin@ncsa.uiuc.edu'],
    #description => 'Make daily backup of propagated database on local disk'
  }

  # Do we still need this?  cpl 16feb23
  #
  # Put principal information into MySQL database
  # 50 0 * * * /var/kerberos/krb5kdc/mysql/insert.pl
  cron { '/var/kerberos/krb5kdc/mysql/insert.pl':
    command     => '/var/kerberos/krb5kdc/mysql/insert.pl',
    user        => 'root',
    hour        => '0',
    minute      => '50',
    environment => ['SHELL=/bin/sh', 'MAILTO=kerberos-admin@ncsa.uiuc.edu'],
    #description => 'Put principal information into MySQL database'
  }

}
