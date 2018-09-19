set output "dhrystone-stm8-size.svg"
set terminal svg size 640,480
set style data lines
set xlabel "revision"
set ylabel "size [B]"
set arrow from 9256, 8223 to 9256, 8123
set label "3.5.0" at 9256, 8223
set arrow from 9618, 8240 to 9618, 8140
set label "3.6.0" at 9618, 8240
set arrow from 10233, 8066 to 10233, 7966
set label "3.7.0" at 10233, 8066
plot "dhrystone-stm8-sizetable" using 1:4 title "default", "dhrystone-stm8-sizetable" using 1:2 title "size", "dhrystone-stm8-sizetable" using 1:3 title "speed"

