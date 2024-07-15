# @summary Configure an Kerberos server for use at NCSA
#
# @example
#   include profile_kerberos_server::secondary
#
class profile_kerberos_server::secondary {
  include profile_kerberos_server::common
  include profile_kerberos_server::secondary::firewall
  include profile_kerberos_server::secondary::scripts
  include profile_kerberos_server::secondary::config
  include profile_kerberos_server::secondary::services
}
