define cloudfuse::mount (
  $username,
  $key,
  $gid,
  $authurl              = "https://auth.api.rackspacecloud.com/v1.0",
  $region		= "DFW",
  $use_servicenet	= true,
  $verify_ssl		= true,
  $umask		= 007,
  $atboot		= true,
  $other_options	= ["defaults", "allow_other"]
)
{
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

  file { $name:
    ensure => directory
  } ->
  mount { $name:
    ensure => mounted,
    atboot => $atboot,
    device => cloudfuse,
    fstype => fuse,
    options => join($mount_options, ","),
    pass => 0,
    remounts => false
  }
}
