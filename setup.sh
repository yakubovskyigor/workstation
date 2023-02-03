#!/usr/bin/env bash

set -o errexit
set -o nounset

ubuntu_packages=(
  atool
  bash
  bash-completion
  bat
  bpytop
  bzip2
  ccrypt
  clamav
  cloc
  cmake
  colordiff
  curl
  fd-find
  fdupes
  ffmpeg
  fzf
  git
  git-extras
  git-gui
  git-lfs
  git-secret
  gnupg
  grep
  gzip
  htop
  ioping
  iotop
  jq
  keepassxc
  less
  lshw
  make
  makeself
  mc
  nano
  ncdu
  nmap
  okular
  openssl
  pigz
  pipenv
  putty
  python3
  rsync
  seahorse
  shellcheck
  silversearcher-ag
  sqlite
  ssh
  sysstat
  telegram-desktop
  tig
  tree
  unrar
  unzip
  virtualbox
  wget
  xclip
  xz-utils
)

python_packages=(
  auditwheel
  black
  flake8
  isort
  mypy
  pre-commit
  pylint
  twine
  virtualenv
)

# Ask for the administrator's password in advance.
sudo --validate

# Keep-alive: update existing user's password timestamp until this script finishes on the current machine.
while true; do sudo --non-interactive true; sleep 60; kill -s 0 "$$" || exit; done 2> /dev/null &

# Step -- 1.
sudo apt-get --quiet update

# Step -- 2.
sudo apt-get --quiet upgrade --yes

# Step -- 3.
sudo apt-get --quiet install --yes -- "${ubuntu_packages[@]}"
sudo sh -c "$(curl https://raw.githubusercontent.com/vladpunko/detach-process/master/install.sh)"

# Step -- 4.
python3 -m pip install --user --upgrade pip setuptools wheel
python3 -m pip install --user --upgrade -- "${python_packages[@]}"

# Step -- 5.
cp dot_aliases.bash "${HOME}/.aliases.bash"
cp dot_bash_logout "${HOME}/.bash_logout"
cp dot_bash_profile "${HOME}/.bash_profile"
cp dot_bashrc "${HOME}/.bashrc"
cp dot_exports.bash "${HOME}/.exports.bash"
cp dot_functions.bash "${HOME}/.functions.bash"
cp dot_inputrc "${HOME}/.inputrc"

cp dot_gitconfig "${HOME}/.gitconfig"
cp dot_gitignore_global "${HOME}/.gitignore_global"

cp dot_flake8rc "${HOME}/.flake8"
cp dot_pylintrc "${HOME}/.pylintrc"
