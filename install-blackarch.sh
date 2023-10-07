#!/bin/bash
url='https://blackarch.org/strap.sh'
filename=${url##*/}

expect(){
    local e=$?
    (( $e )) && exit $e
}

SUDO(){
    local SUDO=
    (( $EUID )) && SUDO=sudo
    $SUDO ${@}
}

main(){
    curl -O $url
    echo $1 $filename | $2 -c
    expect
    SUDO bash $filename
    SUDO pacman -Syu
}

main 5ea40d49ecd14c2e024deecf90605426db97ea0c sha1sum
