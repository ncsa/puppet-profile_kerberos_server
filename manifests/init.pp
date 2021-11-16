# @summary Configure an Kerberos server for use at NCSA
#
# @example
#   include profile_kerberos_server
class profile_kerberos_server {

  include kerberos_server::firewall
  include kerberos_server::scripts
  include kerberos_server::services

}
