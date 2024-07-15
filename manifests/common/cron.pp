# @summary common Kerberos crontab entries 
#
# @example
#   include profile_kerberos_server::common::cron
#
class profile_kerberos_server::common::cron {
# Make daily backup of propagated database on local disk
# 03 04 * * * /root/cron_scripts/krb5_ss_backup.pl
  cron { 'ss_backup':
    command     => '/root/cron_scripts/krb5_ss_backup.pl',
    user        => 'root',
    hour        => 4,
    minute      => 3,
    environment => ['SHELL=/bin/sh', 'MAILTO=kerberos-admin@ncsa.uiuc.edu'],
    #description => 'Make daily backup of propagated database on local disk'
  }

# Roll the kerberos logs to AFS
# 0 0 * * * /root/cron_scripts/mv_krb5_log > /dev/null 2>&1
  cron { 'mv_krb5_log':
    command     => '/root/cron_scripts/mv_krb5_log',
    user        => 'root',
    hour        => 0,
    minute      => 0,
    environment => ['SHELL=/bin/sh', 'MAILTO=kerberos-admin@ncsa.uiuc.edu'],
    #description => 'Roll the kerberos logs to AFS'
  }

# Roll the syslogs to AFS
# 0 1 * * * /root/cron_scripts/mv_syslogs > /dev/null 2>&1
  cron { 'mv_syslogs':
    command     => '/root/cron_scripts/mv_syslogs',
    user        => 'root',
    hour        => 0,
    minute      => 1,
    environment => ['SHELL=/bin/sh', 'MAILTO=kerberos-admin@ncsa.uiuc.edu'],
    #description => 'Roll the syslogs to AFS'
  }
}
