function curl-cert() {
  openssl s_client -showcerts -connect "${1}":443 -servername ${1}
}
