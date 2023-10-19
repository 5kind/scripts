# src
bg=/usr/share/backgrounds/archlinux/archwave.png
lt=/usr/share/backgrounds/archlinux/archwaveinv.png
# config
size=2000x1200
compose=Darken
dl=/sdcard/Download
in=$dl/input
out=$dl/output
# pre-out
mkdir -p $in $out $out/part{1,2}
convert $bg -resize $size^ -gravity center -extent $size $in/bg.png
convert $lt -resize $size^ -gravity center -extent $size $in/lt.png
# out-main
cos() {
    local degree=$1
    printf "degree=$degree; pi=4*a(1); radian=degree*pi/180; c=c(radian); c" | bc -l
}

degree_percent() {
    local number=$(cos $1)
    printf " ( $number/2 +0.5 )*100 " | bc -l
}

blend_degree(){
    local degree_i=$1
    local lt=$2
    local bg=$3
    local outfmt=${4:-"output%03d.jpg"}
    local max_degree=${5:-"360"}

    for (( i=$degree_i; i<=$max_degree; i+=$degree_i)) ;do
        blend_percent=$( degree_percent $(($i + 180)) )
        composite -compose $compose -blend $blend_percent $lt $bg $(printf "$outfmt" $(( $i/$degree_i )))
    done
}

unzip -oqq /system/media/bootanimation.zip -d /tmp
cp -r /tmp/{part1,country.png} $out
cat <<EOF > $out/desc.txt
2000 1200 30
p 1 0 part1
p 0 0 part2
EOF
blend_degree 45 $in/bg.png /tmp/part1/lenovo_1_powerup_main_003.png $out/part1/lenovo_2_powerup_main_%03d.png 180
blend_degree 6 $in/{lt,bg}.png $out/part2/lenovo_2_powerup_loop_%03d.png
cd $out
zip $in/bootanimation.zip *