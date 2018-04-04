set output "whetstone-mcs51-score.svg"
set terminal svg size 640,480
set style data lines
set key bottom right
set xlabel "revision"
set arrow from 9618, 6070 to 9618, 6060
set arrow from 10233, 6073 to 10233, 6063
plot "whetstone-mcs51-scoretable" using 1:4 title "default", "whetstone-mcs51-scoretable" using 1:2 title "size", "whetstone-mcs51-scoretable" using 1:3 title "speed"

