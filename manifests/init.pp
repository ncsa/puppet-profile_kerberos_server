# @summary Configure an Kerberos server for use at NCSA
#
# @example
#   include profile_kerberos_server::primary
#
#   - OR -
#
#   include profile_kerberos_server::secondary
#
class profile_kerberos_server {

  $notify_text = @("EOT"/)
    The top level profile_backup class should not be used.
    Instead use one of the following classes:
      - profile_kerberos_server::primary
      - profile_kerberos_server::secondary
    | EOT
  notify { $notify_text:
    withpath => true,
    loglevel => 'warning',
  }

  # questions:

  #   should slave_kdcs file be updated through puppet?  Should it query DNS realtime or take a 
  #      parameter?  Or should it be cron-generated?
  #   should the KDCs run AFS to store backup files?  Is there a better solution?  Should that
  #      install be managed via xCAT install/puppet?
  #   should we manage /var/kerberos/krb5kdc/mysql/ scripts from within puppet (I think so)
  # is the watchafsbackup.pl script needed
  # is the 'crontab' file in root up-to-date
  # do we want /var/kerberos/krb5kdc/mysql/insert.pl
  # create a service for watchlogins.pl

}
