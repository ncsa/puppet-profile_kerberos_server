# @summary Configure an Kerberos server for use at NCSA
#
# @example
#   include profile_kerberos_server
class profile_kerberos_server {

  include profile_kerberos_server::firewall
  include profile_kerberos_server::scripts
  include profile_kerberos_server::services

}
