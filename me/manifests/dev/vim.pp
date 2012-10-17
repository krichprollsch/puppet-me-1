# ensure vim installed with pathogen and other stuff
class me::dev::vim {
  $packagename = $::operatingsystem ? {
      /(Ubuntu|Debian)/ => 'vim-nox',
  }

  package { 'vim':
    ensure => present,
    name   => $me::dev::vim::packagename,
  }

  file { "/home/${me::username}/.vimrc":
    source  => 'puppet:///modules/me/dotfiles/vimrc',
    require => Class['me::user'],
  }

  file { "/home/${me::username}/.vim":
    ensure  => directory,
    owner   => $me::username,
    group   => $me::username,
    mode    => '0644',
    require => [ Class['me::user'], Package['vim'] ],
  }

  # installing pathogen
  file { "/home/${me::username}/.vim/bundle":
    ensure  => directory,
    owner   => $me::username,
    group   => $me::username,
    mode    => '0644',
    require => [ Package['vim'], File["/home/${me::username}/.vim"] ],
  }

  file { "/home/${me::username}/.vim/autoload":
    ensure  => directory,
    owner   => $me::username,
    group   => $me::username,
    mode    => '0775',
    require => [ Package['vim'], File["/home/${me::username}/.vim"] ],
  }

  file { 'pathogen':
    ensure  => present,
    source  => 'puppet:///modules/me/vendor/pathogen/autoload/pathogen.vim',
    name    => "/home/${me::username}/.vim/autoload/pathogen.vim",
    mode    => '0664',
    require => [
        File["/home/${me::username}/.vim/autoload"],
        File["/home/${me::username}/.vim/bundle"],
    ],
  }

  # include general purpose vim bundles
  # solarized is the color scheme
  vcsrepo { "/home/${me::username}/.vim/bundle/vim-colors-solarized":
    ensure   => present,
    provider => git,
    source   => 'git://github.com/altercation/vim-colors-solarized.git',
    require  => File['pathogen'],
  }
  # fugitive.vim is a git client
  vcsrepo { "/home/${me::username}/.vim/bundle/vim-fugitive":
    ensure   => present,
    provider => git,
    source   => 'git://github.com/tpope/vim-fugitive.git',
    require  => File['pathogen'],
  }
  # install snipmate
  vcsrepo { "/home/${me::username}/.vim/bundle/vim-snipmate":
    ensure   => present,
    provider => git,
    source   => 'git://github.com/garbas/vim-snipmate.git',
    require  => File['pathogen'],
  }
  # and dependencies
  vcsrepo { "/home/${me::username}/.vim/bundle/tlib_vim":
    ensure   => present,
    provider => git,
    source   => 'https://github.com/tomtom/tlib_vim.git',
    require  => File['pathogen'],
  }
  vcsrepo { "/home/${me::username}/.vim/bundle/vim-addon-mw-utils":
    ensure   => present,
    provider => git,
    source   => 'https://github.com/MarcWeber/vim-addon-mw-utils.git',
    require  => File['pathogen'],
  }
  vcsrepo { "/home/${me::username}/.vim/bundle/snipmate-snippets":
    ensure   => present,
    provider => git,
    source   => 'https://github.com/honza/snipmate-snippets.git',
    require  => File['pathogen'],
  }
}