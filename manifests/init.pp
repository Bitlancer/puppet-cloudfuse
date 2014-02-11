class cloudfuse {
  package { cloudfuse:
    ensure => present,
    provider => yum
  }
}
