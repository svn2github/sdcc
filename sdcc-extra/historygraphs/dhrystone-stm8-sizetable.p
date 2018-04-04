set output "dhrystone-stm8-size.svg"
set terminal svg size 640,480
set style data lines
set xlabel "revision"
set ylabel "size [B]"
set arrow from 9256, 8173 to 9256, 8123
set arrow from 9618, 8190 to 9618, 8140
set arrow from 10233, 8016 to 10233, 7966
plot "dhrystone-stm8-sizetable" using 1:4 title "default", "dhrystone-stm8-sizetable" using 1:2 title "size", "dhrystone-stm8-sizetable" using 1:3 title "speed"

