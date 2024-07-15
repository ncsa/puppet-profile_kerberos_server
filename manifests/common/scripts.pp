# @summary Configure scripts for Kerberos services
#
# @example
#   include profile_kerberos_server::common::scripts
#
class profile_kerberos_server::common::scripts {
  file { '/root/cron_scripts/krb5_passwd_check':
    source => "puppet:///modules/${module_name}/root/cron_scripts/krb5_passwd_check",
    mode   => '0755',
  }

  file { '/root/cron_scripts/krb5_sm_backup.pl':
    source => "puppet:///modules/${module_name}/root/cron_scripts/krb5_sm_backup.pl",
    mode   => '0755',
  }

  file { '/root/cron_scripts/krb5_ss_backup.pl':
    source => "puppet:///modules/${module_name}/root/cron_scripts/krb5_ss_backup.pl",
    mode   => '0755',
  }

  file { '/root/cron_scripts/mv_krb5_log':
    source => "puppet:///modules/${module_name}/root/cron_scripts/mv_krb5_log",
    mode   => '0700',
  }

  file { '/root/cron_scripts/mv_syslogs':
    source => "puppet:///modules/${module_name}/root/cron_scripts/mv_syslogs",
    mode   => '0700',
  }

  file { '/root/cron_scripts/watchafsbackup.pl':
    source => "puppet:///modules/${module_name}/root/cron_scripts/watchafsbackup.pl",
    mode   => '0755',
  }

  file { '/root/cron_scripts/watchlogins.pl':
    source => "puppet:///modules/${module_name}/root/cron_scripts/watchlogins.pl",
    mode   => '0700',
  }
}
