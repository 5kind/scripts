root_require(){
  if [ "$(id -u)" -ne 0 ] ;then
    sudo ${0}
    exit
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
root_require
pkg_remove
apt_ban
