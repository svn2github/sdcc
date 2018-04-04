set output "whetstone-stm8-size.svg"
set terminal svg size 640,480
set style data lines
set xlabel "revision"
set ylabel "size [B]"
set arrow from 9256, 11958 to 9256, 11858
set arrow from 9618, 11976 to 9618, 11876
set arrow from 10233, 11528 to 10233, 11428
plot "whetstone-stm8-sizetable" using 1:4 title "default", "whetstone-stm8-sizetable" using 1:2 title "size", "whetstone-stm8-sizetable" using 1:3 title "speed"

