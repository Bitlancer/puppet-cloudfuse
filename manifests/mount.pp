define cloudfuse::mount (
  $username,
  $key,
  $gid      = 0,
  $authurl              = "https://auth.api.rackspacecloud.com/v1.0",
  $region		= "DFW",
  $use_servicenet	= true,
  $verify_ssl		= true,
  $umask		= 007,
  $atboot		= true,
  $other_options	= ["defaults", "allow_other"]
)
{

  include cloudfuse

  Class['cloudfuse'] -> Cloudfuse::Mount["$title"]

  $mount_options = concat([
      "umask=${umask}",
      "gid=${gid}",
      "username=${username}",
      "api_key=${key}",
      "authurl=${authurl}",
      "region=${region}",
      "use_snet=${use_servicenet}",
      "verify_ssl=${verify_ssl}"
    ],
    $other_options
  )

  file { "$title":
    ensure => directory
  } ->
  mount { "$title":
    ensure => mounted,
    atboot => $atboot,
    device => cloudfuse,
    fstype => fuse,
    options => join($mount_options, ","),
    pass => 0,
    remounts => false
  }
}
