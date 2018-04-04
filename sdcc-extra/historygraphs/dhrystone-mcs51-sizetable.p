set output "dhrystone-mcs51-size.svg"
set terminal svg size 640,480
set style data lines
set xlabel "revision"
set ylabel "size [B]"
set arrow from 9618, 12845 to 9618, 12795
set arrow from 10233, 13154 to 10233, 13104
plot "dhrystone-mcs51-sizetable" using 1:4 title "default", "dhrystone-mcs51-sizetable" using 1:2 title "size", "dhrystone-mcs51-sizetable" using 1:3 title "speed"

