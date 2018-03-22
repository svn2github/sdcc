set output "dhrystone-mcs51-score.svg"
set terminal svg size 640,480
set style data lines
set key bottom right
set arrow from 9618, 6070 to 9618, 6060
set arrow from 10233, 6073 to 10233, 6063
plot "dhrystone-mcs51-scoretable" using 1:4 title "default", "dhrystone-mcs51-scoretable" using 1:2 title "size", "dhrystone-mcs51-scoretable" using 1:3 title "speed"

