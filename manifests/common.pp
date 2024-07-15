# @summary Configure an Kerberos server for use at NCSA
#
# @example
#   include profile_kerberos_server::common
#
class profile_kerberos_server::common {
  include profile_kerberos_server::common::firewall
  include profile_kerberos_server::common::scripts
  include profile_kerberos_server::common::cron
  include profile_kerberos_server::common::config
  include profile_kerberos_server::common::services
}
