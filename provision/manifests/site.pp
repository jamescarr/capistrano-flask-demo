node appserver {
  include ::nginx
  include ::supervisor

  class { 'python':
    version    => '3',
    dev        => true,
    virtualenv => true,
    gunicorn   => true,
  }

  # setup users
  user { 'deploy':
    ensure => present,
    group   => 'app',
    require => [User['app'], Group['app']],
  }
  user { 'app': 
    ensure => present,
    group  => 'app',
    require => Group['app'],
  }
  group { 'app': 
    ensure => present,
  }

#  supervisor::service { 'app':
#      ensure         => present,
#      enable         => true,
#      command        => '',
#      user           => $user,
#      directory      => $app_dir,
#      stdout_logfile => $stdout_log,
#      stderr_logfile => $stderr_log,
#      environment    => $environment,
#      stopsignal     => 'KILL',
#      autorestart    => true,
#      startsecs      => $startsecs,
#      priority       => 300,
#  }
}

node guest {

}
