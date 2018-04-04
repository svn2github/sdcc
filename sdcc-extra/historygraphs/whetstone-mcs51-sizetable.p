set output "whetstone-mcs51-size.svg"
set terminal svg size 640,480
set style data lines
set xlabel "revision"
set ylabel "size [B]"
set arrow from 9618, 19980 to 9618, 19930
set arrow from 10233, 20094 to 10233, 20044
plot "whetstone-mcs51-sizetable" using 1:4 title "default", "whetstone-mcs51-sizetable" using 1:2 title "size", "whetstone-mcs51-sizetable" using 1:3 title "speed"

