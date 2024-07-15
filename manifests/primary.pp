# @summary Configure an Kerberos server for use at NCSA
#
# @example
#   include profile_kerberos_server::primary
#
class profile_kerberos_server::primary {
  include profile_kerberos_server::common
  include profile_kerberos_server::primary::firewall
  include profile_kerberos_server::primary::scripts
  include profile_kerberos_server::primary::cron
  include profile_kerberos_server::primary::config
  include profile_kerberos_server::primary::services
}
