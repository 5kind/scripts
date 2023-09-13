pre_remove(){
  if [ "$(id -u)" -ne 0 ] ;then
    exec sudo bash ${0}
  fi

  if ! command -v snap 2>&1 >/dev/null ;then
    apt_ban
    exit 0
  fi
}

snap_remove(){
  for p in $(snap list | awk '{print $1}'); do
     snap remove $p
  done
}

pkg_remove(){
  snap_remove
  snap_remove
  snap_remove
  apt autoremove --purge snapd
}

apt_ban(){
   cat > /etc/apt/preferences.d/no-snapd.pref << EOF
# To prevent repository packages from triggering the installation of snap,
# this file forbids snapd from being installed by apt
Package: snapd
Pin: release a=*
Pin-Priority: -10
EOF
}

# main
pre_remove
pkg_remove
apt_ban
