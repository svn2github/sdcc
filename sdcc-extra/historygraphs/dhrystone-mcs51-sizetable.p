set output "dhrystone-mcs51-size.svg"
set terminal svg size 640,480
set style data lines
set arrow from 9256, 10442 to 9256, 10392
set arrow from 9618, 10381 to 9618, 10331
set arrow from 10233, 10634 to 10233, 10584
plot "dhrystone-mcs51-sizetable" using 1:4 title "default", "dhrystone-mcs51-sizetable" using 1:2 title "size", "dhrystone-mcs51-sizetable" using 1:3 title "speed"

